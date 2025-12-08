extends Node2D
@export var summon_scene : PackedScene
@export var spawn_cooldown : float = 1.0
var _spawn_allowed: bool = true
var _spawn_cd_timer: Timer = null


@export var animate_state : Array[String] = ["idle","attack","skill","summon"]
@export var animation_duration: float = 2.0

signal boss_died
signal hp_changed(current_hp: int, max_hp: int)

@export var max_hp: int = 36
var current_hp: int = 36

@export var move_speed: float = 50.0
@export var move_range: float = 200.0  # Phạm vi di chuyển từ vị trí ban đầu
@export var min_wait_time: float = 1.0  # Thời gian chờ tối thiểu trước khi chọn điểm mới
@export var max_wait_time: float = 3.0  # Thời gian chờ tối đa

@onready var sprite: AnimatedSprite2D = $CharacterBody2D/Boss
@onready var body: CharacterBody2D = $CharacterBody2D
var timer: Timer
var current_animation_index: int = 0

var start_position: Vector2
var target_position: Vector2
var wait_timer: Timer
var is_waiting: bool = false
var stuck_timer: float = 0.0
var last_position: Vector2
var stuck_threshold: float = 0.5  # Nếu không di chuyển quá 0.5 giây thì coi như bị kẹt

@export var AllDirectionSpike: PackedScene
@export var spikeSpawnFrequency: int = 3

func _ready() -> void:
	current_hp = max_hp
	emit_signal("hp_changed", current_hp, max_hp)
	
	# Store starting position
	start_position = global_position
	
	# Setup animation timer
	if sprite and animate_state.size() > 0:
		sprite.play(animate_state[current_animation_index])
		timer = Timer.new()
		timer.wait_time = animation_duration
		timer.autostart = true
		timer.one_shot = false
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
		# Spawn cooldown timer
	_spawn_cd_timer = Timer.new()
	_spawn_cd_timer.wait_time = spawn_cooldown
	_spawn_cd_timer.one_shot = true
	_spawn_cd_timer.timeout.connect(_on_spawn_cd_timeout)
	add_child(_spawn_cd_timer)
	# Setup wait timer for movement
	wait_timer = Timer.new()
	wait_timer.one_shot = true
	wait_timer.timeout.connect(_on_wait_timer_timeout)
	add_child(wait_timer)
	
	# Initialize last position
	last_position = global_position
	
	# Choose initial target position
	_choose_new_target()
	
	
	
	# Connect to Area2D for arrow detection and player collision
	var area = $CharacterBody2D/Area2D
	if area:
		area.area_entered.connect(_on_area_entered)
		area.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	if is_waiting or not body:
		return
	
	# Check if boss is stuck (not moving)
	var current_pos = global_position
	if last_position.distance_to(current_pos) < 1.0:  # Boss không di chuyển
		stuck_timer += delta
		if stuck_timer >= stuck_threshold:
			# Boss bị kẹt, chọn hướng mới
			_choose_new_target()
			stuck_timer = 0.0
	else:
		stuck_timer = 0.0
	last_position = current_pos
	
	# Move towards target position
	var direction = (target_position - global_position).normalized()
	var distance_to_target = global_position.distance_to(target_position)
	
	if distance_to_target > 5.0:  # If not close enough to target
		body.velocity = direction * move_speed
		
		# Flip sprite based on movement direction
		if sprite:
			if direction.x > 0:  # Moving right
				sprite.flip_h = false
			elif direction.x < 0:  # Moving left
				sprite.flip_h = true
		
		var previous_velocity = body.velocity
		body.move_and_slide()
		
		# Check if boss hit a wall (velocity was significantly reduced)
		if body.get_slide_collision_count() > 0:
			# Hit a wall, try a different direction
			var collision = body.get_slide_collision(0)
			if collision:
				# Reflect direction off the wall
				var normal = collision.get_normal()
				direction = direction.bounce(normal).normalized()
				# Choose a new target in the reflected direction
				target_position = global_position + direction * move_range * 0.5
	else:
		# Reached target, wait before choosing new target
		body.velocity = Vector2.ZERO
		_start_waiting()

func _on_timer_timeout() -> void:
	if sprite and animate_state.size() > 0:
		current_animation_index = (current_animation_index + 1) % animate_state.size()
		sprite.play(animate_state[current_animation_index])
		var anim_name = animate_state[current_animation_index]
		sprite.play(anim_name)

		
		if anim_name == "summon" and _spawn_allowed:
			_spawn_summoner()
			_spawn_allowed = false
			if _spawn_cd_timer:
				_spawn_cd_timer.start()

func _spawn_summoner() -> void:
	
		var s = summon_scene.instantiate()

		# spawn ngay tại boss
		s.global_position = body.global_position + Vector2(0, -8 )

		# truyền reference nếu có
		if s.has_method("set_owner_boss"):
			s.set_owner_boss(self)

		# add summon vào parent
		if get_parent():
			get_parent().add_child(s)
		else:
			get_tree().get_root().add_child(s)

		print("Spawned Summoner at ", s.global_position)


func _on_spawn_cd_timeout() -> void:
	_spawn_allowed = true


func _choose_new_target() -> void:
	# Choose a random position within move_range from start_position
	var angle = randf() * TAU  # Random angle in radians
	var distance = randf() * move_range  # Random distance
	target_position = start_position + Vector2(cos(angle), sin(angle)) * distance
	is_waiting = false

func _start_waiting() -> void:
	is_waiting = true
	var wait_time = randf_range(min_wait_time, max_wait_time)
	wait_timer.wait_time = wait_time
	wait_timer.start()

func _on_wait_timer_timeout() -> void:
	_choose_new_target()

func take_damage(amount: int = 1) -> void:
	current_hp -= amount
	print("Boss took damage! HP: ", current_hp, "/", max_hp)
	emit_signal("hp_changed", current_hp, max_hp)
	
	if current_hp>0 and (max_hp-current_hp)%spikeSpawnFrequency==0:
		print("shoots all direction")
		spawn_all_direction_spike()
	
	if current_hp <= 0:
		current_hp = 0
		emit_signal("hp_changed", current_hp, max_hp)
		die()

func die() -> void:
	print("Boss defeated!")
	emit_signal("boss_died")
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	# Check if the area is an arrow
	var area_name = area.name
	if area_name == "Arrow" or "Arrow" in area_name:
		take_damage(1)
		# Remove the arrow
		if is_instance_valid(area):
			area.queue_free()

func _on_body_entered(body: Node2D) -> void:
	# Check if the body is the player
	if body.is_in_group("Player"):
		if body.has_method("die"):
			body.die("boss")
			
func spawn_all_direction_spike():
	if AllDirectionSpike == null:
		push_warning("AllDirectionSpike is not assigned!")
		return
	var spike = AllDirectionSpike.instantiate()
	spike.position = target_position
	print(spike.position)
	# Defer adding to avoid flushing queries warnings
	call_deferred("_add_spike_and_timer", spike)

func _add_spike_and_timer(spike: Node) -> void:
	if not is_instance_valid(spike):
		return
	if get_tree() == null:
		return
	get_tree().current_scene.add_child(spike)
	# Auto-free after 2 seconds
	var t := Timer.new()
	t.wait_time = 2.5
	t.one_shot = true
	t.timeout.connect(func():
		if is_instance_valid(spike):
			spike.queue_free()
	)
	spike.add_child(t)
	t.start()

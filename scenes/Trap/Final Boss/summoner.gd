extends Node2D

@onready var sprite: AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D
@onready var body: CharacterBody2D = $CharacterBody2D
@onready var hitbox: Area2D = $Area2D   # Detect Player

@export var delay_before_dash := 2.0
@export var dash_speed := 350.0
@export var dash_duration := 0.4

var player: Node
var dash_timer: Timer
var state := "appear"
var dash_dir := Vector2.ZERO


func _ready():
	# tìm player
	var p = get_tree().get_nodes_in_group("Player")
	if p.size() > 0:
		player = p[0]

	# play appear animation
	sprite.play("appear")

	# delay → dash
	var delay := Timer.new()
	delay.one_shot = true
	delay.wait_time = delay_before_dash
	delay.timeout.connect(_start_dash)
	add_child(delay)
	delay.start()

	# dash timer
	dash_timer = Timer.new()
	dash_timer.one_shot = true
	dash_timer.wait_time = dash_duration
	dash_timer.timeout.connect(_end_dash)
	add_child(dash_timer)

	# connect trigger
	hitbox.body_entered.connect(_on_body_entered)


func _start_dash():
	state = "dash"
	sprite.play("idle")

	# tìm hướng lao vào player
	if player:
		dash_dir = (player.global_position - global_position).normalized()
	else:
		dash_dir = Vector2.DOWN

	# flip 
	sprite.flip_h = dash_dir.x < 0

	body.velocity = dash_dir * dash_speed
	dash_timer.start()


func _physics_process(delta):
	if state == "dash":
		body.move_and_slide()

		var count := body.get_slide_collision_count()
		for i in range(count):
			var col = body.get_slide_collision(i)
			var obj = col.get_collider()
			if obj == null:
				continue

			# đụng player (va chạm cứng)
			if obj.is_in_group("Player"):
				obj.die("summoner")  # player chết (nếu muốn)
				_die()
				return

			# gặp tường thì chết
			if obj.is_in_group("Wall") or obj is TileMap or obj is StaticBody2D:
				_die()
				return


func _end_dash():
	_die()


func _die():
	state = "die"
	sprite.play("die")
	await get_tree().create_timer(0.2).timeout
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	# trigger khi chạm player bằng Area2D
	if body.is_in_group("Player"):
		print("Summoner HIT player (trigger)!")
		if body.has_method("die"):
			body.die("summoner")
		_die()

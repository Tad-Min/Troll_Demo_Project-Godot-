extends CharacterBody2D

#signaling
signal died(cause: String)

#adjustable section
@export var speed: float = 100.0
@export var jump_velocity: float = 400.0
@export var gravity_inverted: bool = false
@export var min_jc = 0.75
@export var max_jc = 1.25
@export var MAX_AIR_JUMPS = 1   # only 1 allowed in air by default

#event handling variables
var jump_charge = min_jc
const GRAVITY : int = 4200
var is_on_jumper : bool = false
var last_direction = 0
var is_dead: bool = false
var air_jump_done = 0
var stopmove: bool = false;

func get_jump_velocity() -> float:
	if gravity_inverted:
		return jump_velocity
	else:
		return -jump_velocity
	
func is_on_ground() -> bool:
	if gravity_inverted:
		return is_on_ceiling()
	else:
		return is_on_floor()
		
func _physics_process(delta: float) -> void:
	if is_dead:
		$CollisionShape2D.disabled = true
		air_jump_done = MAX_AIR_JUMPS
	
	# Add the gravity.
	if not is_on_ground():
		var gravity_dir = 1
		if gravity_inverted:
			gravity_dir = -1
		velocity += get_gravity() * delta * gravity_dir
		jump_charge = min_jc
	else:
		air_jump_done = 0

	# Handle jump.
	if not stopmove and not is_on_jumper and Input.is_action_pressed("jump"):
		if is_on_ground():
			if jump_charge<max_jc:
				jump_charge += 0.02
			if last_direction == -1.0:
				$AnimatedSprite2D.play("charge_left")
			else:
				$AnimatedSprite2D.play("charge_right")
					
	if not stopmove and not is_on_jumper and Input.is_action_just_pressed("jump") and not is_on_ground() and air_jump_done < MAX_AIR_JUMPS:
		velocity.y = get_jump_velocity()
		air_jump_done += 1
		$JumpSound.play()
	
	if Input.is_action_just_released("jump"):
		if is_on_ground():
			print(last_direction)
			if last_direction ==1 or $AnimatedSprite2D.animation=="charge_right":
				$AnimatedSprite2D.play("onair_right")
			if last_direction ==-1 or $AnimatedSprite2D.animation=="charge_left":
				$AnimatedSprite2D.play("onair_left")
			velocity.y = get_jump_velocity() * jump_charge
			jump_charge = min_jc
			$JumpSound.play()
			
			
	
	if position.y > 900 or position.y < -900:
		GameData.last_death_cause = "fell_out"
		emit_signal("died", GameData.last_death_cause)

	if is_on_jumper:
		stop_move_1_sec()

	# Handle movement A-D
	var direction := Input.get_axis("move_left", "move_right")
	
	if last_direction != direction and not stopmove:
		if is_on_ground() and jump_charge == min_jc: # jumpcharge = min meaning not charging -> use move animation
			if direction == -1:
				$AnimatedSprite2D.play("left")
			if direction == 1:
				$AnimatedSprite2D.play("right")
			if direction ==0:
				$AnimatedSprite2D.play("idle")	
		if not is_on_ground():
			if direction == -1:
				$AnimatedSprite2D.play("onair_left")
			if direction == 1:
				$AnimatedSprite2D.play("onair_right")
			if direction ==0:
				$AnimatedSprite2D.play("idle")	
	
	if direction == 0 or direction == null:
		if jump_charge==min_jc:
			last_direction=direction
	else:
		last_direction=direction
		
	

	#disable movement for an instant if on jumper
	if direction and !stopmove:
		if jump_charge == min_jc:
			velocity.x = direction * speed
		else:
			velocity.x = direction * speed * 0.25
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	#animation reset after jump
	if is_on_ground() and jump_charge==min_jc:
		last_direction = null

	move_and_slide()

#func _on_animated_sprite_2d_frame_changed():
	#if $AnimatedSprite2D.animation == "jump_right":
	#	if $AnimatedSprite2D.frame == 4 and is_on_ground():
	#		velocity.y = get_jump_velocity() * jump_charge
	#		$JumpSound.play()
	#if $AnimatedSprite2D.animation == "jump_left":
	#	if $AnimatedSprite2D.frame == 4 and is_on_ground():
	#		velocity.y = get_jump_velocity() * jump_charge
	#		$JumpSound.play()


func die(cause: String = "trap") -> bool:
	is_dead = true
	velocity.y = get_jump_velocity()
	$DeathSound.play()
	GameData.last_death_cause = cause
	emit_signal("died", GameData.last_death_cause)
	print("Player died: ", GameData.last_death_cause)
	return true

func stop_move_1_sec() -> void:
	stopmove = true
	await get_tree().create_timer(0.3).timeout
	stopmove = false

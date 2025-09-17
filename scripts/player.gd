extends CharacterBody2D

signal died

@export var speed: float = 100.0
@export var jump_velocity: float = -400.0
var min_jc = 0.75
var max_jc = 1.25
var jump_charge = min_jc
const GRAVITY : int = 4200
var is_on_jumper : bool = false
var last_direction = 0
var lr_anim : bool = true

var is_dead: bool = false
const MAX_AIR_JUMPS = 1   # only 1 allowed in air
var air_jump_done = 0


var stopmove: bool = false;


func _physics_process(delta: float) -> void:
	if is_dead:
		$CollisionShape2D.disabled = true
		air_jump_done = MAX_AIR_JUMPS
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		jump_charge = min_jc
	else:
		air_jump_done = 0

	# Handle jump.
	if not is_on_jumper and Input.is_action_pressed("jump"):
		if is_on_floor():
			if last_direction == -1.0:
				lr_anim=false
				$AnimatedSprite2D.play("jump_left")
				$AnimatedSprite2D.set_frame_and_progress(3,0)
				if jump_charge<max_jc:
					jump_charge += 0.02
			else:
				lr_anim=false
				$AnimatedSprite2D.play("jump_right")
				$AnimatedSprite2D.set_frame_and_progress(3,0)
				if jump_charge<max_jc:
					jump_charge += 0.02
					
	if not stopmove and not is_on_jumper and Input.is_action_just_pressed("jump") and not is_on_floor() and air_jump_done==0:
		velocity.y = jump_velocity
		air_jump_done+=1
		$JumpSound.play()
	
	if Input.is_action_just_released("jump"):
		if is_on_floor():
			if last_direction == -1.0:
				lr_anim=false
				$AnimatedSprite2D.play("jump_left")
			else:
				lr_anim=false
				$AnimatedSprite2D.play("jump_right")
	
	if position.y > 900:
		emit_signal("died")

	if is_on_jumper:
		stop_move_1_sec()

	# Handle movement A-D
	var direction := Input.get_axis("move_left", "move_right")
	if is_dead or stopmove: 
		direction=0
	if last_direction != direction and lr_anim:
		if direction == -1:
			$AnimatedSprite2D.play("left")
		if direction == 1:
			$AnimatedSprite2D.play("right")
		if direction ==0:
			$AnimatedSprite2D.play("idle")	
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
	if $AnimatedSprite2D.animation== "jump_right" and $AnimatedSprite2D.frame == 9:
		last_direction = null
		lr_anim=true
	if $AnimatedSprite2D.animation== "jump_left" and $AnimatedSprite2D.frame == 9:
		last_direction = null
		lr_anim=true

	move_and_slide()
	#press X to die, testing only
	if Input.is_action_just_pressed("die"):
		die()

func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.animation == "jump_right":
		if $AnimatedSprite2D.frame == 4 and is_on_floor():
			velocity.y = jump_velocity*jump_charge
			$JumpSound.play()
	if $AnimatedSprite2D.animation == "jump_left":
		if $AnimatedSprite2D.frame == 4 and is_on_floor():
			velocity.y = jump_velocity*jump_charge
			$JumpSound.play()


func die() -> bool:
	is_dead = true
	velocity.y = jump_velocity
	$DeathSound.play()
	print("Player died")
	return true

func stop_move_1_sec() -> void:
	stopmove = true
	await get_tree().create_timer(0.3).timeout
	stopmove = false

extends CharacterBody2D

signal player_died 

@export var speed: float = 100.0
@export var jump_velocity: float = -400.0
const GRAVITY : int = 4200
var last_direction = 0
var lr_anim : bool = true

const MAX_AIR_JUMPS = 1   # only 1 allowed in air
var air_jump_done = 0

var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if is_dead:
		$CollisionShape2D.disabled = true
		
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		air_jump_done = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			if last_direction == -1.0:
				lr_anim=false
				$AnimatedSprite2D.play("jump_left")
			else:
				lr_anim=false
				$AnimatedSprite2D.play("jump_right")
		else:
			if air_jump_done==0:
				velocity.y = jump_velocity
				air_jump_done+=1
				$JumpSound.play()





	# Handle movement A-D
	var direction := Input.get_axis("move_left", "move_right")
	if last_direction != direction and lr_anim:
		if direction == -1:
			$AnimatedSprite2D.play("left")
		if direction == 1:
			$AnimatedSprite2D.play("right")
		if direction ==0:
			$AnimatedSprite2D.play("idle")	
	last_direction=direction

	if direction:
		velocity.x = direction * speed
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
		if $AnimatedSprite2D.frame == 4:
			velocity.y = jump_velocity
			$JumpSound.play()
	if $AnimatedSprite2D.animation == "jump_left":
		if $AnimatedSprite2D.frame == 4:
			velocity.y = jump_velocity
			$JumpSound.play()


func die() -> bool:
	emit_signal("player_died") # notify GameCenter
	is_dead = true 
	return true

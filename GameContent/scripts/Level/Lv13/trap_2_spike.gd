extends "res://scripts/Trap/spike.gd"

@export var move_distance: float
@export var speed: float
@export var loop: bool
@export var direction: Vector2

var start_position: Vector2
var moving_forward := true

func _ready() -> void:
	super._ready()
	start_position = position
	set_process(false)
	set_physics_process(false)
	
func _process(delta: float) -> void:
	if direction == Vector2.ZERO:
		return
	var move_amount = direction.normalized() * speed * delta
	if moving_forward:
		position += move_amount
		if (position - start_position).length() >= move_distance:
			if loop:
				moving_forward = false
			else:
				set_process(false)
				queue_free()
	else:
		position -= move_amount
		if (position - start_position).length() <= 1.0:
			moving_forward = true

func start():
	set_process(true)
	set_physics_process(true)

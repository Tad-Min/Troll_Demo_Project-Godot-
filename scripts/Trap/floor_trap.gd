extends Node2D

@export var move_distance: float
@export var speed: float
@export var loop: bool
@export var direction: Vector2

var start_position: Vector2
var moving_forward := true
var direction_normalized := Vector2.ZERO

func _ready() -> void:
	start_position = position
	direction_normalized = direction.normalized() if direction != Vector2.ZERO else Vector2.ZERO

func _physics_process(delta: float) -> void:
	if direction_normalized == Vector2.ZERO:
		return

	var move_amount := direction_normalized * speed * delta

	if moving_forward:
		position += move_amount
		# Reverse when reaching/passing the forward bound; clamp to exact endpoint
		var traveled_forward := (position - start_position).dot(direction_normalized)
		if traveled_forward >= move_distance:
			position = start_position + direction_normalized * move_distance
			if loop:
				moving_forward = false
			else:
				set_physics_process(false)
	else:
		position -= move_amount
		# Reverse when reaching/passing the start; clamp back to exact start
		var traveled_back := (position - start_position).dot(direction_normalized)
		if traveled_back <= 0.0:
			position = start_position
			moving_forward = true

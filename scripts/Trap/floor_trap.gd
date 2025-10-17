extends Node2D

@export var move_distance: float
@export var speed: float
@export var loop: bool
@export var direction: Vector2

var start_position: Vector2
var moving_forward := true

func _ready() -> void:
	start_position = position

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
	else:
		position -= move_amount
		if (position - start_position).length() <= 1.0:
			moving_forward = true

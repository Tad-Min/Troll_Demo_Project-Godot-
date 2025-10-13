extends Node2D

@export var move_distance: float
@export var speed: float
@export var loop: bool
@export var direction: Vector2
@export var timeAppear:float=3.0
@export var spike:NodePath

var start_position: Vector2
var moving_forward := true

func _ready() -> void:
	start_position = position
	var trap = get_node(spike)
	trap.set_process(false)
	trap.set_physics_process(false)
	trap.visible  = false
	trap.get_node("Area2D").monitoring = false

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
				await get_tree().create_timer(timeAppear).timeout
				var trap = get_node(spike)
				trap.set_process(true)
				trap.set_physics_process(true)
				trap.visible  = true
				trap.get_node("Area2D").monitoring = true
	else:
		position -= move_amount
		if (position - start_position).length() <= 1.0:
			moving_forward = true

extends "res://scripts/Trap/shuriken.gd"

@export var move_distance: float
@export var speed_move: float
@export var loop: bool
@export var direction: Vector2

var start_position: Vector2
var moving_forward := true

func _ready() -> void:
	super._ready()
	start_position = position
	set_process(false)
	visible = false

func _process(delta: float) -> void:
	super._process(delta)
	if direction == Vector2.ZERO:
		return
	var move_amount = direction.normalized() * speed_move * delta
	if moving_forward:
		position += move_amount
		if (position - start_position).length() >= move_distance:
			if loop:
				moving_forward = false
			else:
				set_process(false)
				await get_tree().create_timer(1.0).timeout
				queue_free()
	else:
		position -= move_amount
		if (position - start_position).length() <= 1.0:
			moving_forward = true
			
func start():
	visible = true
	set_process(true)
	

extends "res://scripts/Trap/shuriken.gd"

@export var move_distance: float
@export var speed_move: float
@export var loop: bool
@export var direction: Vector2

var start_position: Vector2
var moving_forward := true
var isActive:= false
func _ready() -> void:
	super._ready()
	start_position = position
	visible = false
	set_process(false)
	monitoring = false

func _process(delta: float) -> void:
	super._process(delta)
	if not isActive:
		await get_tree().create_timer(2.0).timeout
		isActive = true
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
	else:
		position -= move_amount
		if (position - start_position).length() <= 1.0:
			moving_forward = true
func start():
	visible = true
	set_process(true)
	monitoring = true
	

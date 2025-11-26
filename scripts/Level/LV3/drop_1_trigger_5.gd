extends "res://scripts/Trap/floor_trap.gd"

func _ready() -> void:
	super()
	start_position = position
	set_process(false)
	set_physics_process(false)
	visible = false

func start() -> void:
	set_process(true)
	set_physics_process(true)
	visible = true;
	moving_forward = true
	

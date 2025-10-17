extends "res://scripts/Trap/spike.gd"

func _ready() -> void:
	super._ready()
	get_node("Area2D").monitoring = false
	visible = false
	set_physics_process(false)
	
func start():
	get_node("Area2D").monitoring = true
	visible = true
	set_physics_process(true)

extends "res://scripts/Trap/floor_trap.gd"


func _ready() -> void:
	super._ready()
	set_process(false)
	set_physics_process(false)

func activate_trap() -> void:
	set_physics_process(true)
	
	var timer = Timer.new()
	timer.wait_time = 5.0
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	queue_free()

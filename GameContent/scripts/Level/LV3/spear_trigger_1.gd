extends "res://scripts/Trap/spear.gd"

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	visible = false
	$Area2D.monitoring = false

func start() -> void:
	visible = true
	set_process(true)
	set_physics_process(true)
	$AnimatedSprite2D.play("Spear")
	$Area2D.monitoring = true

	var timer = Timer.new()
	timer.wait_time = 3.0
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	queue_free()

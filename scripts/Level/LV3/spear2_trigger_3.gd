extends "res://scripts/spear.gd"

func _ready() -> void:
	set_process(false)
	set_physics_process(false)
	visible = false
	$Area2D.monitoring = false
	$Area2D.monitorable = false

func start() -> void:
	visible = true
	set_process(true)
	set_physics_process(true)
	$AnimatedSprite2D.play("Spear")
	$Area2D.monitoring = true
	$Area2D.monitorable = true

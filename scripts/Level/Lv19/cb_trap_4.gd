extends Node2D
func _ready() -> void:
	$Area2D/SpikeSimple.visible = false
	$Area2D/SpikeSimple/Area2D.monitoring = false
	$Area2D.monitoring = false
	
func start() -> void:
	$Area2D.monitoring = true

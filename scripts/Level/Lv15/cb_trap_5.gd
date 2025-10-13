extends Node2D

func _ready() -> void:
	$Button5.visible = false
	$Button5/Area2D.monitoring = false
	
	$Trap5.monitoring = false
	$Trap5/SpikeSimple5.visible = false
	$Trap5/SpikeSimple5/Area2D.monitoring = false
func start() -> void:
	$Button5.visible = true
	$Button5/Area2D.monitoring = true
	
	$Trap5.monitoring = true

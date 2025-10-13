extends Node2D

func _ready() -> void:
	$Button8.visible = false
	$Button8/Area2D.monitoring = false
	
	$Trap8.monitoring = false
	$Trap8/SpikeSimple8.visible = false
	$Trap8/SpikeSimple8/Area2D.monitoring = false
	
func start() -> void:
	$Button8.visible = true
	$Button8/Area2D.monitoring = true
	
	$Trap8.monitoring = true

extends Node2D

func _ready() -> void:
	$Button8.visible = false
	$Button8/Area2D.monitoring = false
	
	$Trap8.monitoring = false
	$Trap8/SpikeSimple8.visible = false
	$Trap8/SpikeSimple8/Area2D.monitoring = false
	
func start() -> void:
	$Button7_1.visible = true
	$Button7_2.visible = true
	
	$Trap8.monitoring = true

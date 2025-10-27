extends Node2D

func _ready() -> void:
	$Button10.visible = false
	$Button10/Area2D.monitoring = false
	
	$Trap10.monitoring = false
	$Trap10/SpikeSimple10.visible = false
	$Trap10/SpikeSimple10/Area2D.monitoring = false
	
	$Portal.visible = false
	$Portal/Area2D.monitoring = false
func start() -> void:
	$Button10.visible = true
	$Button10/Area2D.monitoring = true
	
	$Trap10.monitoring = true
	
	$Portal.visible = true
	$Portal/Area2D.monitoring = true
	
	

extends Node2D

func _ready() -> void:
	$Button2.visible =  false
	$Button2/Area2D.monitoring = false
	
	$Trap2/SpikeSimple2.visible = false
	$Trap2/SpikeSimple2/Area2D.monitoring = false
	
	$Trap2.monitoring = false

func start():
	$Button2.visible =  true
	$Button2/Area2D.monitoring = true
	$Trap2.monitoring = true

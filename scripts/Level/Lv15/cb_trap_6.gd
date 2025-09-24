extends Node2D

func _ready() -> void:
	$Button6.visible = false
	$Button6/Area2D.monitoring = false
	
	$Trap6.monitoring = false
	$Trap6/SpikeSimple6_1.visible = false
	$Trap6/SpikeSimple6_1/Area2D.monitoring = false
	
	$Trap6/SpikeSimple6_2.visible = false
	$Trap6/SpikeSimple6_2/Area2D.monitoring = false

func start() -> void:
	$Button6.visible = true
	$Button6/Area2D.monitoring = true
	
	$Trap6.monitoring = true

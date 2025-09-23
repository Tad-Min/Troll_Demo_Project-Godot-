extends Node2D

func _ready() -> void:
	$Button9.visible = false
	$Button9/Area2D.monitoring = false
	
	$Trap9_1.monitoring = false
	$Trap9_1/SpikeSimple9_1.visible = false
	$Trap9_1/SpikeSimple9_1/Area2D.monitoring = false
	
	$Trap9_2.monitoring = false
	$Trap9_2/SpikeSimple9_2.visible = false
	$Trap9_2/SpikeSimple9_2/Area2D.monitoring = false
	
	$Trap9_3.monitoring = false
	$Trap9_3/SpikeSimple9_3.visible = false
	$Trap9_3/SpikeSimple9_3/Area2D.monitoring = false
func start() -> void:
	$Button9.visible = true
	$Button9/Area2D.monitoring = true
	
	$Trap9_1.monitoring = true
	$Trap9_2.monitoring = true
	$Trap9_3.monitoring = true
	
	

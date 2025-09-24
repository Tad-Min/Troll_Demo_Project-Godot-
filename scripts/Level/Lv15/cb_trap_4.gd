extends Node2D

func _ready() -> void:
	$Button4.visible = false
	$Button4/Area2D.visible = false
	
	$Trap4_1.monitoring = false
	$Trap4_1/SpikeSimple4_1.visible = false
	$Trap4_1/SpikeSimple4_1/Area2D.monitoring = false
	
	$Trap4_2.monitoring = false
	$Trap4_2/Spike4_2.visible = false
	$Trap4_2/Spike4_2/Area2D.monitoring = false
	
func start() -> void:
	$Button4.visible = true
	$Button4/Area2D.visible = true
	
	$Trap4_1.monitoring = true
	$Trap4_2.monitoring = true

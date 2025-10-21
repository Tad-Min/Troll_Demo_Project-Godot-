extends Node2D

func _ready() -> void:
	$Area2D.monitoring = false
	$"../Pad/Floor".visible = false
	$"../Pad/Floor".collision_enabled = false
	$Area2D/Fly/SpikeSimple1_trap3.visible = false
	$Area2D/Fly/SpikeSimple2_trap3.visible = false
	$Area2D/Fly/SpikeSimple1_trap3/Area2D.monitoring = false
	$Area2D/Fly/SpikeSimple2_trap3/Area2D.monitoring = false
	
func start() -> void:
	$Area2D.monitoring = true
	$"../Pad/Floor".collision_enabled = true

extends Node2D

func _ready() -> void:
	$Button3.visible =  false
	$Button3/Area2D.monitoring = false
	
	$Trap3_1.monitoring = false
	$Trap3_1/SpikeSimple3_1.visible = false
	$Trap3_1/SpikeSimple3_1/Area2D.monitoring = false
	
	$Trap3_2.monitoring = false
	$Trap3_2/Spike3_2.visible = false
	$Trap3_2/Spike3_2/Area2D.monitoring = false
	
func start():
	$Button3.visible =  true
	$Button3/Area2D.monitoring = true
	
	$Trap3_1.monitoring = true
	$Trap3_2.monitoring = true

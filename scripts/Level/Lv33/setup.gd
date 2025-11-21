extends Node2D

func _ready() -> void:
	$Button/Area2D.monitoring = false
	$SpikeSimple/Area2D.monitoring = false
	$Trap2.monitoring = false
	$Button.connect("buttonActivated", Callable(self,"_buttonActivated"))
	
func _buttonActivated():
	$SpikeSimple/Area2D.monitoring = true
	$Trap2.monitoring = true
	
	$moveFloor1.visible
	$moveFloor1.isMove = true
	$moveFloor1.start()

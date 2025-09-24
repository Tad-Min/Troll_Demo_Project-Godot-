extends Node2D

func _ready() -> void:
	$Button7_1.visible = false
	$Button7_2.visible = false
	
	$Button7_1/Area2D.monitoring = false
	$Button7_2/Area2D.monitoring = false
	
func start() -> void:
	$Button7_1.visible = true
	$Button7_2.visible = true
	
	$Button7_1/Area2D.monitoring = true
	$Button7_2/Area2D.monitoring = true

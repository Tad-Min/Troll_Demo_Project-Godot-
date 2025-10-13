extends Node2D

func _ready() -> void:
	$Area2D.monitoring = false
	$"../Pad/Floor".visible = false
	$"../Pad/Floor".collision_enabled = false
	
func start() -> void:
	$Area2D.monitoring = true
	$"../Pad/Floor".collision_enabled = true

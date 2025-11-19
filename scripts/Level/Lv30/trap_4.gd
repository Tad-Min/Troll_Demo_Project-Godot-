extends Area2D

func _ready():
	connect("area_entered", Callable(self, "_on_enter"))

func _on_enter(_area: Area2D):
	call_deferred("set_monitoring", false)
	$"../FloorUp".isMove = true
	$"../FloorUp".start()

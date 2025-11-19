extends Area2D

func _ready() -> void:
	connect("area_entered", Callable(self, "_area_entered"))
	
func _area_entered(area: Node) -> void:
	call_deferred("set_monitoring", false)
	$"../FloorUp".isMove = true
	$"../FloorUp".start()

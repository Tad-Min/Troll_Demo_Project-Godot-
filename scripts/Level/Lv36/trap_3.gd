extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		$RDoor.isMove = true
		$RDoor.start()
		$"../Trap4".monitoring = true
		$"../Trap5/LDoor".isMove = true
		$"../Trap5/LDoor".start()

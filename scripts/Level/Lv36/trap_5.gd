extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		$LDoor.newPosition =  Vector2(64.0,-32.0)
		$LDoor.isMove = true
		$LDoor.start()
		
		await get_tree().create_timer(3).timeout
		$LDoor.newPosition =  Vector2(64.0,-208.0)
		$LDoor.isMove = true
		$LDoor.start()
		

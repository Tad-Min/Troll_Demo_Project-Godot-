extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		var move_floor = get_node_or_null("../moveFloor2")
		if move_floor:
			move_floor.isMove = true
			move_floor.start()

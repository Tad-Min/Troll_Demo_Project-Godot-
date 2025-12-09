extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		var rotate_floor = get_node_or_null("../rotateFloor")
		if rotate_floor:
			rotate_floor.isRotate = true
			rotate_floor.start()
		var button = get_node_or_null("../Button")
		if button:
			button.visible = true
			var button_area = button.get_node_or_null("Area2D")
			if button_area:
				button_area.monitoring = true

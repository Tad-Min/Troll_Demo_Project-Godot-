extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$"../Rotate_Simple_Spike".move_distance = 504
		$"../Rotate_Simple_Spike".speed = 110
		$"../Rotate_Simple_Spike".direction = Vector2(1,0)
		$"../Rotate_Simple_Spike".isMove = true
		call_deferred("set_monitoring", false)

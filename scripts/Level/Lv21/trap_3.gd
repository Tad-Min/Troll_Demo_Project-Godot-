extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$"../Spike2".start()
		call_deferred("set_monitoring", false)
		$"../Trap4".call_deferred("set_monitoring", true)

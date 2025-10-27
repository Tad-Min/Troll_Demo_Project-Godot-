extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		set_deferred("monitoring", false)
		$Up.start()
		await get_tree().create_timer(3.0).timeout
		$RighToLeft.start()
		

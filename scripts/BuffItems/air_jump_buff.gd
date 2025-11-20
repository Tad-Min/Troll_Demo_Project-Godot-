extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if body.has_method("air_jump_buff"):  # make sure the player has buff function
			print("")
			body.air_jump_buff()
			self.get_parent().queue_free()

extends Area2D

# Emitted when the player collects this gem
signal collected

func _ready() -> void:
	add_to_group("normal_gem")
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		return
	emit_signal("collected")
	get_parent().queue_free()

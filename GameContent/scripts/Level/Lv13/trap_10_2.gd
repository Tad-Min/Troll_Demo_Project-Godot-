extends Area2D

@export var shuriken: NodePath

func _ready() -> void:
	if shuriken:
		connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print(name + ": Not Assign yet")
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(shuriken).start()
		queue_free()

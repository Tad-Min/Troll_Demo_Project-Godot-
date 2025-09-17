extends Area2D

@export var elevator: NodePath

func _ready() -> void:
	if elevator:
		connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print(name + ": Not Assign yet")
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(elevator).start()
		queue_free()

extends Area2D

@export var spear: NodePath

func _ready() -> void:
	if spear:
		connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print(name + ": Not Assign yet")
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(spear).start()
		queue_free()

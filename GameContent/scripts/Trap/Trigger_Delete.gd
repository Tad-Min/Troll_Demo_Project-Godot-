extends Area2D

@export var node: NodePath

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		var node_dl = get_node(node)
		if node_dl:
			node_dl.queue_free()
			queue_free()
		else:
			print("Node not found!");

extends Area2D

@export var block: NodePath
func _ready() -> void:
	if block:
		connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print(name + ": Not Assign yet")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(block).start()
		await get_tree().create_timer(2).timeout
		
		queue_free()
		

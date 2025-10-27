extends Area2D

@export var nextArea: NodePath 
@export var spike: NodePath

func _ready() -> void:
	if spike and nextArea:
		get_node(nextArea).monitoring = false
		connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print(name + ": Not Assign yet")
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(spike).start()
		await get_tree().create_timer(2).timeout
		get_node(nextArea).monitoring = true
		queue_free()

extends Area2D

@export var spike: NodePath
@export var jumper: NodePath

func _ready() -> void:
	if spike and jumper:
		get_node(jumper).visible = false
		connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print(name + ": Not Assign yet")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(jumper).visible = true
		get_node(spike).start()
		queue_free()
		

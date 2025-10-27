extends Area2D

@export var Trap_Door: NodePath

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		var Door = get_node(Trap_Door)
		if Door:
			Door.queue_free()
			queue_free()
		else:
			print("Trap node not found!");

extends Area2D

@export var Rotate_Spear: NodePath
@export var Trap_Door: NodePath

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		if Rotate_Spear:
			var rSpear = get_node(Rotate_Spear)
			var Door = get_node(Trap_Door)
			if rSpear and Door:
				rSpear.start()
				Door.queue_free()
				queue_free()
			else:
				print("Trap node not found!");

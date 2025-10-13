extends Area2D

@export var trap_node: NodePath  

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	print("trigger Trap 4 ready")
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if trap_node:
			var trap = get_node(trap_node)
			if trap:
				trap.activate_trap()
				queue_free()
			else:
				print("Trap node not found!")

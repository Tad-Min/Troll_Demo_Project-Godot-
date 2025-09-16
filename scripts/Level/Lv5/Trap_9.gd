extends Area2D

@export var Trap: NodePath

func _ready() -> void:
	if Trap:
		connect("body_entered",Callable(self, "_on_body_entered"))
	else:
		print("Error "+ name + " Assign null")

func _on_body_entered(body: Node) -> void:
	if Trap and body.is_in_group("Player"):
		var trap = get_node(Trap)
		trap.start()
		queue_free()
	

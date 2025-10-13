extends Area2D

@export var Trap: NodePath

func _ready() -> void:
	if Trap:
		connect("body_entered",Callable(self, "_on_body_entered"))
		
	else:
		print("Error Area2D with name:"+ name + " -> Assign null")
		
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(Trap).scale.x +=2

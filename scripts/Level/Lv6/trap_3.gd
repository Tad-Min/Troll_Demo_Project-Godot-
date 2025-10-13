extends Area2D

@export var Trap: NodePath
@export var Map: NodePath
func _ready() -> void:
	if Trap and Map:
		connect("body_entered",Callable(self, "_on_body_entered"))
	else:
		print("Error "+ name + " Assign null")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(Trap).start()
		await get_tree().create_timer(4).timeout
		get_node(Map).queue_free()
		queue_free()
	

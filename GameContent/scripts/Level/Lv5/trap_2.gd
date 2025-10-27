extends Area2D

@export var Map: NodePath

func _ready() -> void:
	if Map:
		connect("body_entered",Callable(self, "_on_body_entered"))
	else:
		print("Error "+ name + " Assign null")

func _on_body_entered(body: Node) -> void:
	if Map and body.is_in_group("Player"):
		get_node(Map).queue_free()
		queue_free()
	

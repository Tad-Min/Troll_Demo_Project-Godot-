extends Area2D

@export var Map: NodePath
@export var Saw: NodePath

func _ready() -> void:
	if Map and Saw:
		get_node(Map).visible = false
		get_node(Saw)._set_shurikens_active(false)
		connect("body_entered",Callable(self, "_on_body_entered"))
	else: 
		print("Error "+ name + " Assign null")

func _on_body_entered(body: Node) -> void:
	if Map and Saw and body.is_in_group("Player"):
		get_node(Map).visible = true
		get_node(Saw).start_rotation()
		queue_free()

extends Area2D

@export var Trap: NodePath

func _ready() -> void:
	if Trap:
		get_node(Trap).set_process(false)
		get_node(Trap).set_physics_process(false)
		get_node(Trap).visible  = false
		get_node(Trap).get_node("Area2D").monitoring = false
		connect("body_entered",Callable(self, "_on_body_entered"))
	else:
		print("Error "+ name + " Assign null")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(Trap).set_process(true)
		get_node(Trap).set_physics_process(true)
		get_node(Trap).visible  = true
		get_node(Trap).get_node("Area2D").monitoring = true
		await get_tree().create_timer(2.0).timeout
		get_node(Trap).queue_free()
		queue_free()
	

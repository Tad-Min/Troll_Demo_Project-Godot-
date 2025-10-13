extends Area2D

@export var TrapL: NodePath
@export var TrapR: NodePath
func _ready() -> void:
	if TrapL and TrapR:
		get_node(TrapL).set_process(false)
		get_node(TrapL).set_physics_process(false)
		get_node(TrapL).visible  = false
		get_node(TrapL).get_node("Area2D").monitoring = false
		
		get_node(TrapR).set_process(false)
		get_node(TrapR).set_physics_process(false)
		get_node(TrapR).visible  = false
		get_node(TrapR).get_node("Area2D").monitoring = false
		
		connect("body_entered",Callable(self, "_on_body_entered"))
	else:
		print("Error "+ name + " Assign null")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(TrapL).set_process(true)
		get_node(TrapL).set_physics_process(true)
		get_node(TrapL).visible  = true
		get_node(TrapL).get_node("Area2D").monitoring = true
		
		get_node(TrapR).set_process(true)
		get_node(TrapR).set_physics_process(true)
		get_node(TrapR).visible  = true
		get_node(TrapR).get_node("Area2D").monitoring = true
		
		queue_free()
	

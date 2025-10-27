extends Area2D

@export var Trap: NodePath

func _ready() -> void:
	if Trap:
		var trap = get_node(Trap)
		trap.set_process(false)
		trap.set_physics_process(false)
		trap.visible  = false
		trap.get_node("Area2D").monitoring = false
	else:
		print("Error Trap1 Assign null")
	connect("body_entered",Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	var trap = get_node(Trap)
	if body.is_in_group("Player"):
		trap.set_process(true)
		trap.set_physics_process(true)
		trap.visible  = true
		trap.get_node("Area2D").monitoring = true
		queue_free()
	

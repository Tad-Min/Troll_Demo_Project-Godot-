extends Area2D

@export var Trap: NodePath
@export var Map: NodePath
func _ready() -> void:
	if Trap and Map:
		var trap = get_node(Trap)
		trap.set_process(false)
		trap.set_physics_process(false)
		trap.visible  = false
		trap.get_node("Area2D").monitoring = false
		connect("body_entered",Callable(self, "_on_body_entered"))
	else:
		print("Error Trap8 Assign null")

func _on_body_entered(body: Node) -> void:
	if Trap and Map and body.is_in_group("Player"):
		var trap = get_node(Trap)
		var map = get_node(Map)
		trap.set_process(true)
		trap.set_physics_process(true)
		trap.visible  = true
		trap.get_node("Area2D").monitoring = true
		map.queue_free()
		queue_free()

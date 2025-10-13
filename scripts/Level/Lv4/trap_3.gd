extends Area2D

@export var Trap: NodePath

func _ready() -> void:
	if Trap:
		var trap = get_node(Trap)
		trap.visible = false
		trap.set_process(false)
		trap.set_physics_process(false)
		trap.monitoring = false
		connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print("Trap3 not Assign Trap")

func _on_body_entered(body: Node) -> void:
	if Trap and body.is_in_group("Player"):
		var trap = get_node(Trap)
		trap.visible = true
		trap.set_process(true)
		trap.set_physics_process(true)
		trap.monitoring = true
		queue_free()

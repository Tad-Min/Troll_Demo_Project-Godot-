extends Area2D

@export var Trap: NodePath
@export var TimeDisappear: float = 2.0
func _ready() -> void:
	if Trap and TimeDisappear >= 0:
		var trap = get_node(Trap)
		trap.visible = false
		trap.set_process(false)
		trap.set_physics_process(false)
		trap.get_node("Area2D").monitoring = false
		connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print("Trap10 not Assign Trap and TimeDisappear must > 0")
		
func _on_body_entered(body: Node) -> void:
	if Trap and body.is_in_group("Player"):
		var trap = get_node(Trap)
		trap.visible = true
		trap.set_process(true)
		trap.set_physics_process(true)
		trap.get_node("Area2D").monitoring = true
		await get_tree().create_timer(TimeDisappear).timeout
		trap.queue_free()
		queue_free()

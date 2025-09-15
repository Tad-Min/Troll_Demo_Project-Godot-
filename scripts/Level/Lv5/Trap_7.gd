extends Area2D

@export var Trap: NodePath

func _ready() -> void:
	if Trap:
		var trap = get_node(Trap)
		trap.set_process(false)
		trap.set_physics_process(false)
		trap.visible  = false
		trap.monitoring = false
		connect("body_entered",Callable(self, "_on_body_entered"))
	else:
		print("Error "+ name + " Assign null")

func _on_body_entered(body: Node) -> void:
	if Trap and body.is_in_group("Player"):
		var trap = get_node(Trap)
		trap.set_process(true)
		trap.set_physics_process(true)
		trap.visible  = true
		trap.monitoring = true
		await get_tree().create_timer(2.0).timeout
		trap.queue_free()
		queue_free()
	

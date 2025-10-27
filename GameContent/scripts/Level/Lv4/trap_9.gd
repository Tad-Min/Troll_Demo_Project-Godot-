extends Area2D

@export var Spike: NodePath
@export var Shuriken: NodePath
@export var TimeDisappear: float = 2.0

func _ready() -> void:
	if Spike and Shuriken and TimeDisappear >= 0:
		var spike = get_node(Spike)
		var shuriken = get_node(Shuriken)
		spike.visible = false
		spike.set_process(false)
		spike.set_physics_process(false)
		spike.get_node("Area2D").monitoring = false
		shuriken.visible = false
		shuriken.set_process(false)
		shuriken.set_physics_process(false)
		shuriken.monitoring = false
		connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print("Trap9 not Assign Trap and TimeDisappear must > 0")
		
func _on_body_entered(body: Node) -> void:
	if  Spike and Shuriken and body.is_in_group("Player"):
		var spike = get_node(Spike)
		var shuriken = get_node(Shuriken)
		spike.visible = true
		spike.set_process(true)
		spike.set_physics_process(true)
		spike.get_node("Area2D").monitoring = true
		shuriken.visible = true
		shuriken.set_process(true)
		shuriken.set_physics_process(true)
		shuriken.monitoring = true
		await get_tree().create_timer(TimeDisappear).timeout
		spike.queue_free()
		shuriken.queue_free()
		queue_free()

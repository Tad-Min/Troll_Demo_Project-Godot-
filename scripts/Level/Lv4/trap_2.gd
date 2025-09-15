extends Area2D

@export var Spike: NodePath
@export var Jumper: NodePath

func _ready() -> void:
	if Spike and Jumper:
		var spike = get_node(Spike)
		var jumper = get_node(Jumper)
		spike.visible = false
		jumper.visible = false
		connect("body_entered",Callable(self, "_on_body_entered"))
	else:
		print("Spike and Jumper trap2 not assign")
		
func _on_body_entered(body: Node) -> void:
	if Spike and Jumper and body.is_in_group("Player"):
		var spike = get_node(Spike)
		var jumper = get_node(Jumper)
		spike.visible = true
		jumper. visible = true
		queue_free()

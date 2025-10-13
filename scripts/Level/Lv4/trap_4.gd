extends Area2D

@export var Spike: NodePath
@export var Ls_Jumper: NodePath
@export var MFloor: NodePath

func _ready() -> void:
	if Spike and Ls_Jumper and MFloor:
		var spike = get_node(Spike)
		var ls_Jumper = get_node(Ls_Jumper)
		var mfloor = get_node(MFloor)
		spike.visible = false
		spike.set_process(false)
		spike.set_physics_process(false)
		spike.get_node("Area2D").monitoring = false
		ls_Jumper.visible = false
		mfloor.visible = true
		connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print("Trap4 not Assign Spike,listJumper and floor")
		
func _on_body_entered(body: Node) -> void:
	if Spike and Ls_Jumper and MFloor and body.is_in_group("Player"):
		var spike = get_node(Spike)
		var ls_Jumper = get_node(Ls_Jumper)
		var mfloor = get_node(MFloor)
		spike.visible = true
		spike.set_process(true)
		spike.set_physics_process(true)
		spike.get_node("Area2D").monitoring = true
		ls_Jumper.visible = true
		mfloor.queue_free()
		queue_free()

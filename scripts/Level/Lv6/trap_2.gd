extends Area2D

@export var Trap: NodePath
@export var Spike1: NodePath
@export var Spike2: NodePath
func _ready() -> void:
	if Trap and Spike1 and Spike2:
		get_node(Spike1).visible = false
		get_node(Spike2).visible = false
		
		connect("body_entered",Callable(self, "_on_body_entered"))
	else:
		print("Error "+ name + " Assign null")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		get_node(Trap).start()
		await get_tree().create_timer(1).timeout
		get_node(Spike1).visible = true
		await get_tree().create_timer(2).timeout
		get_node(Spike2).visible = true
		queue_free()
	

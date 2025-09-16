extends Area2D

@export var TrapL: NodePath
@export var TrapR: NodePath
func _ready() -> void:
	if TrapL and TrapR:
		var trapL = get_node(TrapL)
		var trapR = get_node(TrapR)
		trapL.visible  = false
		trapR.visible = false
		
		
		connect("body_entered",Callable(self, "_on_body_entered"))
	else:
		print("Error "+ name + " Assign null")

func _on_body_entered(body: Node) -> void:
	if TrapL and TrapR and body.is_in_group("Player"):
		var trapL = get_node(TrapL)
		var trapR = get_node(TrapR)
		trapR.visible = true
		trapR.start()
		await get_tree().create_timer(1.0).timeout
		trapL.visible  = true
		trapL.start()
		
		queue_free()
	

extends Node2D
func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):  
		if body.has_method("die"): 
			body.die("trap")

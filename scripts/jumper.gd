extends Node2D
 
@export var jump_force: float = 650.0   

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.is_on_jumper = true
		
		var dir: Vector2 = -global_transform.y.normalized()
		body.velocity = dir * jump_force
		
		if $AnimatedSprite2D:
			$AnimatedSprite2D.play("Jumper")
		if $Jumper:
			$Jumper.play()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.is_on_jumper = false

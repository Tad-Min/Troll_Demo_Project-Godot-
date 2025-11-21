extends Node2D
 
@export var jump_force: float  

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		visible=true
		body.is_on_jumper = true
		body.stop_move_1_sec()
		var dir: Vector2 = -global_transform.y.normalized()
		body.velocity = dir * jump_force
		body.air_jump_done = 0
		
		if $AnimatedSprite2D:
			$AnimatedSprite2D.play("Jumper")
		if $Jumper:
			$Jumper.play()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.is_on_jumper = false

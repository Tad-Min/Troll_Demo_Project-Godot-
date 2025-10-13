extends Node2D
var isActive := false

func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and not isActive:
		$AnimatedSprite2D.play("default")
		$Button.play()
		isActive = true
		if body.has_method("die"):
			body.die("trap")

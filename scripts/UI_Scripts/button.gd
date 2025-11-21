extends Node2D
signal buttonActivated
var isActive := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not isActive:
		$AnimatedSprite2D.play("default")
		$Button.play()
		isActive = true
		emit_signal("buttonActivated")

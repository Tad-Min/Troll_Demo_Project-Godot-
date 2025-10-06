extends AnimatedSprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if is_in_group("gem"):
			GameData.add_gem()
		queue_free()

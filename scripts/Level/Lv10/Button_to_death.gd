extends Node2D

var isActive := false

func _ready() -> void:
	if has_node("Area2D"):
		$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if isActive:
		return
	if body.is_in_group("Player"):
		isActive = true
		if has_node("AnimatedSprite2D"):
			$AnimatedSprite2D.play("default")
		if body.has_method("die"):
			body.die()

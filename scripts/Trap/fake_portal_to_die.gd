extends Node2D

func _ready() -> void:
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	print("Fake_portal ready")
	$AnimatedSprite2D.play("idle")


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and body.has_method("die"):
		body.die()

extends Node2D

var isActive := false

func _ready() -> void:
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and not isActive:
		$AnimatedSprite2D.play("default")
		isActive = true

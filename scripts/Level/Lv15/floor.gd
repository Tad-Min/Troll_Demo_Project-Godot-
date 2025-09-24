extends Area2D

@export var ceilling: NodePath

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		body.gravity_inverted = false
		body.rotation_degrees = 0
		body.position.y -= 620

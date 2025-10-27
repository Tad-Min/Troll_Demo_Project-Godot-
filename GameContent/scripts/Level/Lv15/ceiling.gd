extends Area2D

@export var foor : NodePath

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		body.gravity_inverted = true
		body.rotation_degrees = 180
		body.position.y += 620
		

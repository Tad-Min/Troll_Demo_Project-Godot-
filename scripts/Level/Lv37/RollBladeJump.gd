extends Area2D

@export var roller : RigidBody2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and roller != null:
		roller._jump()

extends Node2D

func _ready() -> void:
	$RigidBody2D/CollisionShape2D.scale = self.scale
	$RigidBody2D/Sprite2D.scale = self.scale

func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and body.has_method("die"):
		body.die()

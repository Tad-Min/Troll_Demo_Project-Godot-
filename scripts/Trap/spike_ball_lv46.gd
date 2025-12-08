extends Node2D

@onready var rb: RigidBody2D = $RigidBody2D

func _ready() -> void:
	$RigidBody2D/CollisionShape2D.scale = self.scale
	$RigidBody2D/Sprite2D.scale = self.scale
	visible = false
	if rb:
		rb.gravity_scale = 0.0
		rb.sleeping = true

func start_fall() -> void:
	if not rb:
		return
	visible = true
	rb.gravity_scale = 1.0
	rb.sleeping = false
	rb.linear_velocity = Vector2.ZERO

func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and body.has_method("die"):
		body.die()

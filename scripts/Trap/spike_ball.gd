extends Node2D

@export var speed: float = 300.0

func _ready() -> void:
	$RigidBody2D/Sprite2D.scale = scale
	$RigidBody2D/CollisionShape2D.scale = scale
	
	var dir = Vector2.RIGHT.rotated(randf() * PI * 2) 
	$RigidBody2D.linear_velocity = dir * speed
	

func _physics_process(_delta: float) -> void:
	var vel = $RigidBody2D.linear_velocity
	if vel.length() > 0:
		vel = vel.normalized() * speed
		if abs(vel.x) < 0.1:
			vel.x += randf_range(-0.2, 0.2)
		if abs(vel.y) < 0.1:
			vel.y += randf_range(-0.2, 0.2)
		$RigidBody2D.linear_velocity = vel.normalized() * speed

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	if $RigidBody2D.linear_velocity.length() > 0:
		$RigidBody2D.linear_velocity = $RigidBody2D.linear_velocity.normalized() * speed

func _on_rigid_body_2d_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and body.has_method("die"):
		body.die()

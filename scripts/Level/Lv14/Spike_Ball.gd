extends RigidBody2D

@export var speed: float = 300.0

func _ready():
	var dir = Vector2.RIGHT.rotated(randf() * PI*2) 
	linear_velocity = dir * speed

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	if linear_velocity.length() != 0:
		linear_velocity = linear_velocity.normalized() * speed

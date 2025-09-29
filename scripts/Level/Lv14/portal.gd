extends RigidBody2D

@export var speed:= 300

func _ready() -> void:
	var dir = Vector2.RIGHT.rotated(randf() * PI * 2) 
	linear_velocity = dir * speed
	
func _physics_process(_delta: float) -> void:
	var vel = linear_velocity
	if vel.length() > 0:
		vel = vel.normalized() * speed
		if abs(vel.x) < 0.1:
			vel.x += randf_range(-0.2, 0.2)
		if abs(vel.y) < 0.1:
			vel.y += randf_range(-0.2, 0.2)
		linear_velocity = vel.normalized() * speed

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	if linear_velocity.length() > 0:
		linear_velocity = linear_velocity.normalized() * speed

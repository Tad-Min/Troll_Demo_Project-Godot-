extends RigidBody2D

@export var roll_torque: float = 1000.0
@export var stick_force: float = 50.0

func _ready() -> void:
	$AnimatedSprite2D.play("spin")
	connect("body_entered", Callable(self, "_on_body_entered"))
		
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):  
		if body.has_method("die"):  # make sure the player has die() function
			body.die("trap")
			
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	# Apply torque to spin (rolling)
	apply_torque(roll_torque)

	# Optional: stick to ground
	var ray_origin = global_position
	var ray_end = ray_origin + Vector2(0, 16)

	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(ray_origin, ray_end)
	query.exclude = [self]
	query.collision_mask = collision_mask

	var result = space_state.intersect_ray(query)
	if result:
		apply_central_force(Vector2(0, stick_force))

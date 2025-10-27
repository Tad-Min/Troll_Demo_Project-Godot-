extends Node

@export var player: CharacterBody2D
@export var rolling_blade: RigidBody2D
@export var center_node: Node2D

@export var rotation_amount: float = 10.0        # max tilt angle in degrees
@export var rotation_duration: float = 0.5       # tween duration
@export var trigger_distance: float = 100.0      # distance to start tilt
@export var show_debug: bool = false

var is_tilting: bool = false

func _process(delta: float) -> void:
	if player == null or rolling_blade == null or center_node == null:
		return
	
	var distance = player.global_position.distance_to(rolling_blade.global_position)
	var direction = (player.global_position - rolling_blade.global_position).normalized()

	if show_debug:
		print("Distance: ", distance, " | Direction: ", direction)

	if distance > trigger_distance and not is_tilting:
		_tilt_center(direction.x)


func _tilt_center(dir_x: float) -> void:
	is_tilting = true
	var tilt_direction = sign(dir_x)
	
	# Set a fixed target angle based on direction
	var target_rotation = rotation_amount * tilt_direction

	var tween = create_tween()
	tween.tween_property(
		center_node,
		"rotation_degrees",
		target_rotation,
		rotation_duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# When done, allow next tilt (in case direction flips)
	tween.tween_callback(func():
		is_tilting = false
	)

extends Area2D

@export var Map: Node2D
@export var destination: Vector2 = Vector2(0, 0)          # target world position
@export var rotation_destination: float = 0.0             # target rotation in degrees
@export var move_duration: float = 1.0                    # seconds for smooth movement

@export var nodes_to_free_before: Array[Node] = []        # free these BEFORE tween
@export var nodes_to_free_after: Array[Node] = []         # free these AFTER tween

@export var trap_to_spawn: PackedScene                    # trap scene to instantiate
@export var trap_spawn_pos: Vector2 = Vector2(0, 0)       # spawn position (local to Map)
@export var trap_spawn_rot: float = 0.0                   # rotation in degrees

@export var waiting: bool = false                         # if true, waits for manual activation
@export var activate_before: Array[Node] = []             # triggers to activate before tween
@export var activate_after: Array[Node] = []              # triggers to activate after tween

var _activated := false

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	if waiting:
		monitoring = false

func _on_body_entered(body: Node) -> void:
	if _activated or waiting:
		return
	
	if body.is_in_group("Player") and Map:
		_start_trigger_sequence()

func activate() -> void:
	waiting = false
	monitoring = true
	print("triggered at:", get_parent().name)

func _start_trigger_sequence() -> void:
	_activated = true
	monitoring = false  # prevent retrigger

	# 🔸 Activate others BEFORE tween
	for t in activate_before:
		if t and is_instance_valid(t) and t.has_method("activate"):
			t.activate()

	# 🧹 Free nodes BEFORE tween
	for n in nodes_to_free_before:
		if n and is_instance_valid(n):
			n.queue_free()

	# 💣 Spawn trap before tween (child of Map)
	if trap_to_spawn and Map:
		var trap_instance = trap_to_spawn.instantiate()
		trap_instance.position = trap_spawn_pos
		trap_instance.rotation_degrees = trap_spawn_rot
		Map.add_child(trap_instance)
		nodes_to_free_after.push_back(trap_instance)

	# 🎬 Create tween for movement + rotation
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_property(Map, "position", destination, move_duration)
	tween.parallel().tween_property(Map, "rotation_degrees", rotation_destination, move_duration)

	await tween.finished

	# 🔸 Activate others AFTER tween
	for t in activate_after:
		if t and is_instance_valid(t) and t.has_method("activate"):
			t.activate()

	# 🧹 Free nodes AFTER tween
	for n in nodes_to_free_after:
		if n and is_instance_valid(n):
			n.queue_free()

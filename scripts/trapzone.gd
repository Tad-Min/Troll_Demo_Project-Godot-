extends Area2D

@export var shuriken_scene: PackedScene
@export var cooldown_time: float = 2.0

@onready var right_spawner = $RightSpawner
var can_trigger: bool = true

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player") and can_trigger:
		_spawn_shuriken(right_spawner.global_position, Vector2.LEFT)
		start_cooldown()

func _spawn_shuriken(pos: Vector2, dir: Vector2):
	var s = shuriken_scene.instantiate()
	get_tree().current_scene.add_child(s)
	s.global_position = pos
	s.velocity = dir  # nhớ trong script Shuriken phải có biến "velocity"

func start_cooldown():
	can_trigger = false
	await get_tree().create_timer(cooldown_time).timeout
	can_trigger = true

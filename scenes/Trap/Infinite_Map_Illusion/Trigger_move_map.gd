extends Area2D

@export var Map: Node2D
@export var move_distance: Vector2 = Vector2(500, 0)  # how far to teleport each trigger
@export var camera : Camera2D
func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and Map and not camera.zoom == Vector2(1,1):
		Map.position += move_distance

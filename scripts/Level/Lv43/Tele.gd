extends Node2D
@export var newPosition: Vector2
@export var player: Node2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))

func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		if player:
			player.position = newPosition
		else:
			print("Player is null!")

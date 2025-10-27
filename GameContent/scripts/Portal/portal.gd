extends Node2D

signal player_entered

@export var next_level: int

func _ready() -> void:
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	print("portal ready")
	$AnimatedSprite2D.play("idle")

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		return
	print("Player entered the portal!")
	emit_signal("player_entered")
	
	GameData.current_level = next_level-1
	GameData.Levels[GameData.current_level].isUnlock = true
	GameData.save_progress()
	return

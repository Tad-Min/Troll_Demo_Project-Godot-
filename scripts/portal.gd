extends Node2D

signal player_entered  # custom signal for the game center

@export var next_level_path: String #Change in Inspector
@export var stage_to_unlock: int #Change in Inspector 

func _ready() -> void:
	# connect the Area2D's built-in signal to our handler
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	print("portal ready")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):  # only trigger for the player
		print("Player entered the portal!")
		emit_signal("player_entered")  # notify GameCenter
		GameData.unlock_stage(stage_to_unlock)
		get_tree().change_scene_to_file(next_level_path)
		

extends AnimatedSprite2D;

@export var next_level_path: String = "res://scenes/Level/Lv2.tscn";
@export var stage_to_unlock: int = 1  # unlock stage 2
func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		# Unlock stage tiếp theo
		GameData.unlock_stage(stage_to_unlock)
		GameData.save_progress()

		# Chuyển scene sang map mới
		get_tree().change_scene_to_file(next_level_path)

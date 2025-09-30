extends Control

@onready var death_label: Label = %DeathLabel
@onready var cause_label: Label = %CauseLabel

func _ready() -> void:
	print("DeathLabel is: ", death_label)
	if death_label:
		death_label.text = "Death: %d times" % GameData.Levels[GameData.current_level].countDie
		GameData.save_progress()
	else:
		push_error("DeathLabel is null. Check node path or scene structure.")
	if cause_label:
		var readable = _format_cause(GameData.last_death_cause)
		cause_label.text = "Cause: %s" % readable
	else:
		push_error("CauseLabel is null. Add Label/ CauseLabel in GameOver scene.")

func _pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % (GameData.current_level + 1))


func _format_cause(cause: String) -> String:
	match cause:
		"button":
			return "Pressed the forbidden button"
		"trap":
			return "Killed by a trap"
		"fell_out":
			return "Fell out of the world"
		_:
			return "Unknown"

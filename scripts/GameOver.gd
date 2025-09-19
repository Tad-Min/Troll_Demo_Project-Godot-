extends Control

@onready var death_label: Label = %DeathLabel
@onready var cause_label: Label = %CauseLabel

func _ready() -> void:
	print("DeathLabel is: ", death_label)
	if death_label:
		death_label.text = "Death: %d times" % GameData.death_count
	else:
		push_error("DeathLabel is null. Check node path or scene structure.")
	if cause_label:
		var readable = _format_cause(GameData.last_death_cause)
		cause_label.text = "Cause: %s" % readable
	else:
		push_error("CauseLabel is null. Add Label/ CauseLabel in GameOver scene.")

func _pressed():
	var last_level = get_tree().get_meta("last_level", "")
	print("last level is: ")
	print(last_level)
	if last_level != "":
		get_tree().change_scene_to_file(last_level)
	else:
		push_error("No last_level meta found! Reloading default Lv1.")
		get_tree().change_scene_to_file("res://scenes/Level/Lv1.tscn")

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

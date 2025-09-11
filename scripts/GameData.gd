extends Node
var death_count: int = 0


var level_paths: Array = [
	"res://scenes/Level/Lv1.tscn",
	"res://scenes/Level/Lv2.tscn",
	"res://scenes/Level/Lv3.tscn"
]

var current_level_index: int = 0
var next_level_path: String = ""

# Default: unlock lv1
var unlocked_stages: Array = [true, false, false]

# Unlock stage base on index
func unlock_stage(stage_index: int) -> void:
	if stage_index < unlocked_stages.size():
		unlocked_stages[stage_index] = true
		save_progress() # auto save progress

# Check stage is unlock
func is_stage_unlocked(stage_index: int) -> bool:
	if stage_index < unlocked_stages.size():
		return unlocked_stages[stage_index]
	return false

# Save progress
func save_progress() -> void:
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	var data = { "unlocked": unlocked_stages }
	file.store_string(JSON.stringify(data))

# Load progress
func load_progress() -> void:
	if FileAccess.file_exists("user://save.json"):
		var file = FileAccess.open("user://save.json", FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		if typeof(data) == TYPE_DICTIONARY and data.has("unlocked"):
			unlocked_stages = data["unlocked"]
	else:
		# If file save not found
		unlocked_stages = [true, false, false]

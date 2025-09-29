extends Node

@export var LvSize: int = 15
var unlocked_stages: Array

var death_count: int = 0
var last_death_cause: String = ""

var current_level_index: int = 0
var next_level_path: String = ""

var level_paths: Array = [
	"res://scenes/Level/Lv1.tscn",
	"res://scenes/Level/Lv2.tscn",
	"res://scenes/Level/Lv3.tscn",
	"res://scenes/Level/Lv4.tscn",
	"res://scenes/Level/Lv5.tscn",
	"res://scenes/Level/Lv6.tscn",
	"res://scenes/Level/Lv7.tscn",
	"res://scenes/Level/Lv8.tscn",
	"res://scenes/Level/Lv9.tscn",
	"res://scenes/Level/Lv10.tscn",
	"res://scenes/Level/Lv11.tscn",
	"res://scenes/Level/Lv12.tscn",
	"res://scenes/Level/Lv13.tscn",
	"res://scenes/Level/Lv14.tscn",
	"res://scenes/Level/Lv15.tscn"
]

func _ready() -> void:
	if not load_progress():
		unlocked_stages.resize(LvSize)
		unlocked_stages.fill(false)
		unlocked_stages[0] = true

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
func load_progress() -> bool:
	if FileAccess.file_exists("user://save.json"):
		var file = FileAccess.open("user://save.json", FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		if typeof(data) == TYPE_DICTIONARY and data.has("unlocked"):
			unlocked_stages = data["unlocked"]
			if unlocked_stages.size() < LvSize:
				var old_size = unlocked_stages.size()
				unlocked_stages.resize(LvSize)
				for i in range(old_size, LvSize):
					unlocked_stages[i] = false
			return true
	return false

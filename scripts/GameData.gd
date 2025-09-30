extends Node

class Level: 
	var isUnlock: bool = false
	var countDie: int = 0
	
	func _init(u := false, cd: int = 0 ) -> void:
		isUnlock = u
		countDie = cd
		
	func to_dict() -> Dictionary:
		return {
			"isUnlock": isUnlock,
			"countDie": countDie
		}
		
	func from_dict(data: Dictionary) -> void:
		isUnlock = data.get("isUnlock", false)
		countDie = data.get("countDie", 0)

var LvSize: int = 15
var Levels: Array[Level]

# Save current level
var current_level: int = 0

var last_death_cause: String = ""

func _ready() -> void:
	if Engine.is_editor_hint():
		reset_progress()
	else:
		if not load_progress():
			reset_progress()

# Reset progress
func reset_progress():
	Levels.clear()
	for i in range(LvSize):
		Levels.append(Level.new(i == 0, 0))  # Level 0 unlock
	current_level = 0
	save_progress()

# Unlock stage by index
func unlock_level(levelIndex: int) -> void:
	if levelIndex < Levels.size():
		Levels[levelIndex].isUnlock = true
		save_progress() 

# Check if stage is unlocked
func is_stage_unlocked(levelIndex: int) -> bool:
	if levelIndex < Levels.size():
		return Levels[levelIndex].isUnlock
	return false

# Save progress
func save_progress() -> void:
	var arr: Array = []
	for lv in Levels:
		arr.append(lv.to_dict())
		
	var data = { 
		"levels": arr,
		"current_level": current_level
	}
	var file = FileAccess.open("user://save.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))

# Load progress
func load_progress() -> bool:
	if FileAccess.file_exists("user://save.json"):
		var file = FileAccess.open("user://save.json", FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())

		if typeof(data) == TYPE_DICTIONARY and data.has("levels"):
			Levels.clear()
			for d in data["levels"]:
				var lv = Level.new()
				lv.from_dict(d)
				Levels.append(lv)

			while Levels.size() < LvSize:
				Levels.append(Level.new())

			# Load current level
			if data.has("current_level"):
				current_level = data["current_level"]
				current_level = clamp(current_level, 0, LvSize - 1)
			return true
	return false

extends Node

class Level: 
	var mapId: int = 0
	var isUnlock: bool = false
	var countDie: int = 0
	
	func _init(m:= 0, u := false, cd: int = 0 ) -> void:
		mapId = m
		isUnlock = u
		countDie = cd
		
	func to_dict() -> Dictionary:
		return {
			"mapId" : mapId,
			"isUnlock": isUnlock,
			"countDie": countDie
		}
		
	func from_dict(data: Dictionary) -> void:
		mapId = data.get(mapId, 0)
		isUnlock = data.get("isUnlock", false)
		countDie = data.get("countDie", 0)

var LvSize: int = 30
var Levels: Array[Level]

# Save current level
var current_level: int = 0

var last_death_cause: String = ""

# Global death counter for ads
var total_deaths: int = 0

# UI: per-level gem counter (transient, not persisted)
signal gem_count_changed(current: int, required: int)
var gem_current: int = 0
var gem_required: int = 3

func reset_gems(required: int = 3) -> void:
	gem_required = required
	gem_current = 0
	emit_signal("gem_count_changed", gem_current, gem_required)

func add_gem() -> void:
	gem_current += 1
	emit_signal("gem_count_changed", gem_current, gem_required)

func _ready() -> void:
	if Engine.is_editor_hint():
		reset_progress()
	else:
		if not load_progress():
			reset_progress()
	for i in range(LvSize):
		Levels[i].mapId = i+1

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
		"current_level": current_level,
		"total_deaths": total_deaths
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
			# Load total deaths
			if data.has("total_deaths"):
				total_deaths = data["total_deaths"]
			return true
	return false

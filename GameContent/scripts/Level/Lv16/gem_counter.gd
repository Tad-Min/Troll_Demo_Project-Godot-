extends Label

@export var required_gems: int = 3

func _ready() -> void:
	text = _format_text(GameData.gem_current, required_gems)
	GameData.gem_required = required_gems
	GameData.connect("gem_count_changed", Callable(self, "_on_gem_count_changed"))

func _on_gem_count_changed(current: int, required: int) -> void:
	text = _format_text(current, required)

func _format_text(current: int, required: int) -> String:
	return "Gem: %d/%d" % [current, required]

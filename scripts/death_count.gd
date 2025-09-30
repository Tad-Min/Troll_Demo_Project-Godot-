extends CanvasLayer

func _ready() -> void:
	$RichTextLabel.text = "%d" % GameData.Levels[GameData.current_level].countDie

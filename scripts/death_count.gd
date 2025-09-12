extends CanvasLayer

func _ready() -> void:
	# pull value directly from your StageManager (autoload)
	$RichTextLabel.text = "%d" % GameData.death_count

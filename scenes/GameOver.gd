extends Control

@onready var death_label: Label = $Label/DeathLabel

func _ready() -> void:
	print("DeathLabel is: ", death_label)
	if death_label:
		death_label.text = "Death: %d times" % GameData.death_count
	else:
		push_error("DeathLabel is null. Check node path or scene structure.")

func _pressed():
	var last_level = get_tree().get_meta("last_level", "")
	print("last level is: ")
	print(last_level)
	if last_level != "":
		get_tree().change_scene_to_file(last_level)
	else:
		push_error("No last_level meta found! Reloading default Lv1.")
		get_tree().change_scene_to_file("res://scenes/Level/Lv1.tscn")

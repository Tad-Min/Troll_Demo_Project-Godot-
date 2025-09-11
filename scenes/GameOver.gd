extends Button

func _pressed():
	var last_level = get_tree().get_meta("last_level", "")
	print("last level is: ")
	print(last_level)
	if last_level != "":
		get_tree().change_scene_to_file(last_level)
	else:
		push_error("No last_level meta found! Reloading default Lv1.")
		get_tree().change_scene_to_file("res://scenes/Level/Lv1.tscn")

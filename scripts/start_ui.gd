extends Control

@onready var btn_play: Button = $btnPlay
@onready var btn_exit: Button = $btnExit

func _on_btn_play_pressed():
	print("Play button clicked.")
	var result = get_tree().change_scene_to_file("res://scenes/Level/Lv1.tscn")
	if result != OK:
		push_error("❌ Failed to load scene: res://scenes/Level/Lv1.tscn")

func _on_btn_exit_pressed():
	get_tree().quit()

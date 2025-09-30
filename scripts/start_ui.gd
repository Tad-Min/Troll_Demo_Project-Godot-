extends Control

@onready var btn_play: Button = $btnPlay
@onready var btn_select_level: Button = $btnselectlevel
@onready var btn_exit: Button = $btnExit

func _ready():
	# Check nếu vừa thoát (bị Android restart lại app)
	if Session.is_cold_start:
		Session.is_cold_start = false  # reset để những lần sau không auto quit
		if FileAccess.file_exists("user://just_exited.txt"):
			var f := FileAccess.open("user://just_exited.txt", FileAccess.READ)
			var flag := f.get_as_text()
			DirAccess.remove_absolute("user://just_exited.txt") # xoá cờ
			if flag == "exit":
				get_tree().quit()
				return
	btn_play.pressed.connect(_on_btn_play_pressed)
	btn_exit.pressed.connect(_on_btn_exit_pressed)
	btn_select_level.pressed.connect(_on_btn_select_level_pressed)
	
func _on_btn_play_pressed():
	print("Play button clicked.")
	var result = get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % (GameData.current_level + 1))
	if result != OK:
		push_error("❌ Failed to load scene: res://scenes/Level/Lv%d.tscn" % (GameData.current_level + 1))

func _on_btn_select_level_pressed():
	get_tree().change_scene_to_file("res://scenes/SelectLevel.tscn")

func _on_btn_exit_pressed():
	var file = FileAccess.open("user://just_exited.txt", FileAccess.WRITE)
	file.store_string("exit")
	get_tree().quit()

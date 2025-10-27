extends Control

@onready var btn_play: Button = $btnPlay
@onready var btn_select_level: Button = $btnselectlevel
@onready var btn_exit: Button = $btnExit

func _ready():
	# Không còn cơ chế auto-quit khi khởi động lại
	btn_play.pressed.connect(_on_btn_play_pressed)
	btn_exit.pressed.connect(_on_btn_exit_pressed)
	btn_select_level.pressed.connect(_on_btn_select_level_pressed)
	
func _on_btn_play_pressed():
	print("Play button clicked.")
	var result = get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % (GameData.current_level + 1))
	if result != OK:
		push_error("❌ Failed to load scene: res://scenes/Level/Lv%d.tscn" % (GameData.current_level + 1))

func _on_btn_select_level_pressed():
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel.tscn")

func _on_btn_exit_pressed():
	# Thoát trực tiếp, không ghi bất kỳ cờ nào

	# Use Engine.get_main_loop() to avoid cases where data.tree is null
	var tree := Engine.get_main_loop() as SceneTree
	if tree:
		tree.quit()
	else:
		# Fallback: if for some reason there is no SceneTree, try deferred quit next frame
		call_deferred("_deferred_quit")

func _deferred_quit():
	var tree := Engine.get_main_loop() as SceneTree
	if tree:
		tree.quit()

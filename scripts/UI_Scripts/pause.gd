extends Control

@onready var pause_button = $Button
@onready var pause_panel = $Panel
@onready var continue_button = $Panel/ContinueButton
@onready var restart_button = $Panel/RestartButton
@onready var menu_button = $Panel/MenuButton
@onready var sound_button = $Panel.get_node_or_null("SoundButton")
@onready var select_level_button: Button = $Panel.get_node_or_null("SelectLevelButton")

var camera: Camera2D
var audio_options

func _noop_setget(val): 
	pass

func _ready():
	# Ẩn panel pause khi khởi động
	pause_panel.visible = false
	
	# Lấy node AudioOptions nếu có
	audio_options = pause_panel.get_node_or_null("AudioOptions")
	if audio_options:
		audio_options.visible = false
	else:
		push_error("AudioOptions is null!")

	# Kết nối các nút (kiểm tra tồn tại trước khi connect)
	if pause_button:
		pause_button.pressed.connect(_on_pause_pressed)
	if continue_button:
		continue_button.pressed.connect(_on_continue_pressed)
	if restart_button:
		restart_button.pressed.connect(_on_restart_pressed)
	if menu_button:
		menu_button.pressed.connect(_on_menu_pressed)
	if sound_button:
		sound_button.pressed.connect(_on_sound_button_pressed)
	if is_instance_valid(select_level_button):
		select_level_button.pressed.connect(_on_select_level_pressed)

	# Lấy camera từ Player nếu có
	var player = get_tree().get_first_node_in_group("Player")
	if player and player.has_node("Camera2D"):
		camera = player.get_node("Camera2D")
	else:
		print("⚠️ Player or Camera2D not found!")

# === Pause handling ===
func open_pause_menu():
	get_tree().paused = true
	pause_panel.visible = true
	pause_button.disabled = true

func _on_pause_pressed():
	open_pause_menu()

func _on_continue_pressed():
	get_tree().paused = false
	pause_panel.visible = false
	pause_button.disabled = false

func _on_restart_pressed():
	get_tree().paused = false
	var current_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(current_scene)

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/StartUI.tscn")

func _on_sound_button_pressed():
	if audio_options:
		audio_options.visible = !audio_options.visible

# === Select Level logic ===
func _on_select_level_pressed():
	print("Select Level pressed from pause. current_level:", GameData.current_level)
	get_tree().paused = false
	_go_to_select_scene_by_level(GameData.current_level)

func _go_to_select_scene_by_level(cur_level) -> void:
	if cur_level == null:
		cur_level = 1

	var go_to_select2 := false
	if cur_level >= 13 and cur_level <= 24:
		go_to_select2 = true
	elif cur_level >= 12:
		go_to_select2 = true
	else:
		go_to_select2 = false

	var path := ""
	if go_to_select2:
		path = "res://scenes/GameSceneUI/SelectLevel2.tscn"
	else:
		path = "res://scenes/GameSceneUI/SelectLevel.tscn"

	var packed = ResourceLoader.load(path)
	if packed == null:
		printerr("ERROR: Select scene not found at path:", path)
		return

	print("Changing to select scene:", path)
	get_tree().change_scene_to_file(path)

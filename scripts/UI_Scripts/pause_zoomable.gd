extends Control

@onready var pause_button = $Button
@onready var pause_panel = $Panel
@onready var continue_button = $Panel/ContinueButton
@onready var restart_button = $Panel/RestartButton
@onready var menu_button = $Panel/MenuButton

@onready var sound_button = $Panel/SoundButton

# camera2d zoom settings
@onready var zoom_close_button = $Panel/ZoomCloseButton
@onready var zoom_normal_button = $Panel/ZoomNormalButton
@onready var zoom_far_button = $Panel/ZoomFarButton

var camera: Camera2D
var audio_options

func _ready():
	pause_panel.visible = false
	audio_options = pause_panel.get_node("AudioOptions")
	if audio_options:
		audio_options.visible = false
	else:
		push_error("AudioOptions is null!")
	

	# connect pause buttons
	pause_button.pressed.connect(_on_pause_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)
	if sound_button:
		sound_button.pressed.connect(_on_sound_button_pressed)

	# connect zoom buttons
	zoom_close_button.pressed.connect(_on_zoom_close_pressed)
	zoom_normal_button.pressed.connect(_on_zoom_normal_pressed)
	zoom_far_button.pressed.connect(_on_zoom_far_pressed)

	# safely get camera from Player node
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
	audio_options.visible = !audio_options.visible

# === Zoom handling ===
func _on_zoom_close_pressed():
	if camera:
		camera.zoom = Vector2(3, 3)  # smaller = closer
		print("Zoom → Close")

func _on_zoom_normal_pressed():
	if camera:
		camera.zoom = Vector2(2, 2)
		print("Zoom → Normal")

func _on_zoom_far_pressed():
	if camera:
		camera.zoom = Vector2(1, 1)  # larger = farther
		print("Zoom → Far")

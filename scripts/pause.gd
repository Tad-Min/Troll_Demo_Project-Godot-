extends Control

@onready var pause_button = $Button
@onready var pause_panel = $Panel
@onready var continue_button = $Panel/ContinueButton
@onready var restart_button = $Panel/RestartButton
@onready var menu_button = $Panel/MenuButton

func _ready():
	pause_panel.visible = false  # Ẩn menu lúc đầu

	# Kết nối các nút
	pause_button.pressed.connect(_on_pause_pressed)
	continue_button.pressed.connect(_on_continue_pressed)
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)

func _on_pause_pressed():
	get_tree().paused = true
	pause_panel.visible = true
	pause_button.disabled = true  # Không cho nhấn lại nữa

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
	get_tree().change_scene_to_file("res://scenes/StartUI.tscn")  # Đổi nếu bạn đặt menu ở chỗ khác

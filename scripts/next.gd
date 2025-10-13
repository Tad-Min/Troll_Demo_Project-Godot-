extends Control

@onready var btn_next: TextureButton = $BtnNext
@onready var btn_restart: TextureButton = $BtnRestart
@onready var btn_home: TextureButton = $BtnHome

func _ready() -> void:
	btn_next.pressed.connect(_on_btn_next_pressed)
	btn_restart.pressed.connect(_on_btn_restart_pressed)
	btn_home.pressed.connect(_on_btn_home_pressed)

func _on_btn_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % (GameData.current_level+1))


func _on_btn_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/StartUI.tscn")


func _on_btn_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % (GameData.current_level))

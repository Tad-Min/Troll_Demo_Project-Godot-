extends Control

@onready var back_btn: TextureButton = $BackButton

func _ready():
	back_btn.pressed.connect(_on_back_pressed)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel4.tscn")

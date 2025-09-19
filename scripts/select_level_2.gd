extends Control
@onready var btn_return: Button = $btnReturn
@onready var btn_lv13: Button = $btnlv13
func _ready():
	btn_return.pressed.connect(_on_btn_return_pressed)
	btn_lv13.pressed.connect(_on_btn_lv13_pressed)
	
func _on_btn_return_pressed():
	get_tree().change_scene_to_file("res://scenes/SelectLevel.tscn")
	
func _on_btn_lv13_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv13.tscn")

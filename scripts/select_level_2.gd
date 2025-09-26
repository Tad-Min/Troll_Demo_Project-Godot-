extends Control
@onready var btn_return: Button = $btnReturn
@onready var btn_lv13: Button = $btnlv13
@onready var btn_lv14: Button = $btnlv14
@onready var btn_lv15: Button = $btnlv15

@onready var lock13: TextureRect = $btnlv13/lock13
@onready var lock14: TextureRect = $btnlv14/lock14
@onready var lock15: TextureRect = $btnlv15/lock15
func _ready():
	
	
	btn_return.pressed.connect(_on_btn_return_pressed)
	btn_lv13.pressed.connect(_on_btn_lv13_pressed)
	btn_lv14.pressed.connect(_on_btn_lv14_pressed)
	btn_lv15.pressed.connect(_on_btn_lv15_pressed)
	
func _on_btn_return_pressed():
	get_tree().change_scene_to_file("res://scenes/SelectLevel.tscn")
	
func _on_btn_lv13_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv13.tscn")
	
func _on_btn_lv14_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv14.tscn")
	
func _on_btn_lv15_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv15.tscn")

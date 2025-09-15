extends Control
@onready var btn_lv1: Button = $btnlv1
@onready var btn_lv2: Button = $btnlv2
@onready var btn_lv3: Button = $btnlv3

func _ready():
	btn_lv1.pressed.connect(_on_btn_lv1_pressed)
	btn_lv2.pressed.connect(_on_btn_lv2_pressed)
	btn_lv3.pressed.connect(_on_btn_lv3_pressed)
func _on_btn_lv1_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv1.tscn")

func _on_btn_lv2_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv2.tscn")

func _on_btn_lv3_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv3.tscn")

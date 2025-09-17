extends Control
@onready var btn_lv1: Button = $btnlv1
@onready var btn_lv2: Button = $btnlv2
@onready var btn_lv3: Button = $btnlv3
@onready var btn_lv4: Button = $btnlv4
@onready var btn_lv5: Button = $btnlv5
@onready var btn_lv6: Button = $btnlv6
@onready var btn_lv7: Button = $btnlv7
@onready var btn_lv8: Button = $btnlv8
@onready var btn_lv9: Button = $btnlv9
@onready var btn_lv10: Button = $btnlv10
@onready var btn_lv11: Button = $btnlv11
@onready var btn_next: Button = $btnNext

func _ready():
	btn_lv1.pressed.connect(_on_btn_lv1_pressed)
	btn_lv2.pressed.connect(_on_btn_lv2_pressed)
	btn_lv3.pressed.connect(_on_btn_lv3_pressed)
	btn_lv4.pressed.connect(_on_btn_lv4_pressed)
	btn_lv5.pressed.connect(_on_btn_lv5_pressed)
	btn_lv6.pressed.connect(_on_btn_lv6_pressed)
	btn_lv7.pressed.connect(_on_btn_lv7_pressed)
	btn_lv8.pressed.connect(_on_btn_lv8_pressed)
	btn_lv9.pressed.connect(_on_btn_lv9_pressed)
	btn_lv10.pressed.connect(_on_btn_lv10_pressed)
	btn_lv11.pressed.connect(_on_btn_lv11_pressed)
	btn_next.pressed.connect(_on_btn_next_pressed)
func _on_btn_lv1_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv1.tscn")

func _on_btn_lv2_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv2.tscn")

func _on_btn_lv3_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv3.tscn")
	
func _on_btn_lv4_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv4.tscn")
	
func _on_btn_lv5_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv5.tscn")
	
func _on_btn_lv6_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv6.tscn")
	
func _on_btn_lv7_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv7.tscn")
	
func _on_btn_lv8_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv8.tscn")
	
func _on_btn_lv9_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv9.tscn")
	
func _on_btn_lv10_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv10.tscn")
	
func _on_btn_lv11_pressed():
	get_tree().change_scene_to_file("res://scenes/Level/Lv11.tscn")
	
func _on_btn_next_pressed():
	get_tree().change_scene_to_file("res://scenes/SelectLevel2.tscn")

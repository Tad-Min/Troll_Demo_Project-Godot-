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
@onready var btn_lv12: Button = $btnlv12
@onready var btn_next: Button = $btnNext

# Nếu hình ổ khoá là TextureRect đặt cùng cấp với từng btn:
@onready var lock2: TextureRect = $btnlv2/lock2
@onready var lock3: TextureRect = $btnlv3/lock3
@onready var lock4: TextureRect = $btnlv4/lock4
@onready var lock5: TextureRect = $btnlv5/lock5
@onready var lock6: TextureRect = $btnlv6/lock6
@onready var lock7: TextureRect = $btnlv7/lock7
@onready var lock8: TextureRect = $btnlv8/lock8
@onready var lock9: TextureRect = $btnlv9/lock9
@onready var lock10: TextureRect = $btnlv10/lock10
@onready var lock11: TextureRect = $btnlv11/lock11
@onready var lock12: TextureRect = $btnlv12/lock12


func _ready():
	# Level 1 luôn mở
	btn_lv1.disabled = false
	# Không cần ổ khoá cho lv1

	# Level 2–12: Khóa nếu chưa unlock, mở nếu đã unlock
	

	
	# Kết nối pressed
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
	btn_lv12.pressed.connect(_on_btn_lv12_pressed)
	btn_next.pressed.connect(_on_btn_next_pressed)


func _on_btn_lv1_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv1.tscn")
func _on_btn_lv2_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv2.tscn")
func _on_btn_lv3_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv3.tscn")
func _on_btn_lv4_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv4.tscn")
func _on_btn_lv5_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv5.tscn")
func _on_btn_lv6_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv6.tscn")
func _on_btn_lv7_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv7.tscn")
func _on_btn_lv8_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv8.tscn")
func _on_btn_lv9_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv9.tscn")
func _on_btn_lv10_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv10.tscn")
func _on_btn_lv11_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv11.tscn")
func _on_btn_lv12_pressed(): get_tree().change_scene_to_file("res://scenes/Level/Lv12.tscn")
func _on_btn_next_pressed(): get_tree().change_scene_to_file("res://scenes/SelectLevel2.tscn")

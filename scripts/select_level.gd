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
	btn_lv1.pressed.connect(func(): _on_choose_level(1))
	btn_lv2.pressed.connect(func(): _on_choose_level(2))
	btn_lv3.pressed.connect(func(): _on_choose_level(3))
	btn_lv4.pressed.connect(func(): _on_choose_level(4))
	btn_lv5.pressed.connect(func(): _on_choose_level(5))
	btn_lv6.pressed.connect(func(): _on_choose_level(6))
	btn_lv7.pressed.connect(func(): _on_choose_level(7))
	btn_lv8.pressed.connect(func(): _on_choose_level(8))
	btn_lv9.pressed.connect(func(): _on_choose_level(9))
	btn_lv10.pressed.connect(func(): _on_choose_level(10))
	btn_lv11.pressed.connect(func(): _on_choose_level(11))
	btn_lv12.pressed.connect(func(): _on_choose_level(12))

	btn_next.pressed.connect(_on_btn_next_pressed)
	
	
func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv-1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)

func _on_btn_next_pressed():
	get_tree().change_scene_to_file("res://scenes/SelectLevel2.tscn")

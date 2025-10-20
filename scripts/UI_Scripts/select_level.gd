extends Control
@onready var btn_lv1: Button = $LevelMenu/btnlv1
@onready var btn_lv2: Button = $LevelMenu/btnlv2
@onready var btn_lv3: Button = $LevelMenu/btnlv3
@onready var btn_lv4: Button = $LevelMenu/btnlv4
@onready var btn_lv5: Button = $LevelMenu/btnlv5
@onready var btn_lv6: Button = $LevelMenu/btnlv6
@onready var btn_lv7: Button = $LevelMenu/btnlv7
@onready var btn_lv8: Button = $LevelMenu/btnlv8
@onready var btn_lv9: Button = $LevelMenu/btnlv9
@onready var btn_lv10: Button = $LevelMenu/btnlv10
@onready var btn_lv11: Button = $LevelMenu/btnlv11
@onready var btn_lv12: Button = $LevelMenu/btnlv12



# Nếu hình ổ khoá là TextureRect đặt cùng cấp với từng btn:
#@onready var lock2: TextureRect = $btnlv2/lock2
#@onready var lock3: TextureRect = $btnlv3/lock3
#@onready var lock4: TextureRect = $btnlv4/lock4
#@onready var lock5: TextureRect = $btnlv5/lock5
#@onready var lock6: TextureRect = $btnlv6/lock6
#@onready var lock7: TextureRect = $btnlv7/lock7
#@onready var lock8: TextureRect = $btnlv8/lock8
#@onready var lock9: TextureRect = $btnlv9/lock9
#@onready var lock10: TextureRect = $btnlv10/lock10
#@onready var lock11: TextureRect = $btnlv11/lock11
#@onready var lock12: TextureRect = $btnlv12/lock12


func _ready():
	# Level 1 luôn mở
	#btn_lv1.disabled = false
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

	
	
	
func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv-1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)



func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/StartUI.tscn")


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel2.tscn")
	

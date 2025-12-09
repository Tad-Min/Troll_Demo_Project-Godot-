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


#lock
@onready var lock3: TextureRect = $LevelMenu/btnlv3/lock3 if $LevelMenu/btnlv3.has_node("lock3") else null
@onready var lock4: TextureRect = $LevelMenu/btnlv4/lock4 if $LevelMenu/btnlv4.has_node("lock4") else null
@onready var lock5: TextureRect = $LevelMenu/btnlv5/lock5 if $LevelMenu/btnlv5.has_node("lock5") else null
@onready var lock6: TextureRect = $LevelMenu/btnlv6/lock6 if $LevelMenu/btnlv6.has_node("lock6") else null
@onready var lock7: TextureRect = $LevelMenu/btnlv7/lock7 if $LevelMenu/btnlv7.has_node("lock7") else null
@onready var lock8: TextureRect = $LevelMenu/btnlv8/lock8 if $LevelMenu/btnlv8.has_node("lock8") else null
@onready var lock9: TextureRect = $LevelMenu/btnlv9/lock9 if $LevelMenu/btnlv9.has_node("lock9") else null
@onready var lock10: TextureRect = $LevelMenu/btnlv10/lock10 if $LevelMenu/btnlv10.has_node("lock10") else null
@onready var lock11: TextureRect = $LevelMenu/btnlv11/lock11 if $LevelMenu/btnlv11.has_node("lock11") else null
@onready var lock12: TextureRect = $LevelMenu/btnlv12/lock12 if $LevelMenu/btnlv12.has_node("lock12") else null


func _ready():
	# Level 1 luôn mở
	btn_lv1.disabled = false
	btn_lv2.disabled = false

	# Level 3–12: Khóa nếu chưa unlock, mở nếu đã unlock
	btn_lv3.disabled = not GameData.is_stage_unlocked(2)
	if lock3:
		lock3.visible = not GameData.is_stage_unlocked(2)

	btn_lv4.disabled = not GameData.is_stage_unlocked(3)
	if lock4:
		lock4.visible = not GameData.is_stage_unlocked(3)

	btn_lv5.disabled = not GameData.is_stage_unlocked(4)
	if lock5:
		lock5.visible = not GameData.is_stage_unlocked(4)

	btn_lv6.disabled = not GameData.is_stage_unlocked(5)
	if lock6:
		lock6.visible = not GameData.is_stage_unlocked(5)

	btn_lv7.disabled = not GameData.is_stage_unlocked(6)
	if lock7:
		lock7.visible = not GameData.is_stage_unlocked(6)

	btn_lv8.disabled = not GameData.is_stage_unlocked(7)
	if lock8:
		lock8.visible = not GameData.is_stage_unlocked(7)

	btn_lv9.disabled = not GameData.is_stage_unlocked(8)
	if lock9:
		lock9.visible = not GameData.is_stage_unlocked(8)

	btn_lv10.disabled = not GameData.is_stage_unlocked(9)
	if lock10:
		lock10.visible = not GameData.is_stage_unlocked(9)

	btn_lv11.disabled = not GameData.is_stage_unlocked(10)
	if lock11:
		lock11.visible = not GameData.is_stage_unlocked(10)

	btn_lv12.disabled = not GameData.is_stage_unlocked(11)
	if lock12:
		lock12.visible = not GameData.is_stage_unlocked(11)


	#connect
	btn_lv1.pressed.connect(Callable(self, "_on_choose_level").bind(1))
	btn_lv2.pressed.connect(Callable(self, "_on_choose_level").bind(2))
	btn_lv3.pressed.connect(Callable(self, "_on_choose_level").bind(3))
	btn_lv4.pressed.connect(Callable(self, "_on_choose_level").bind(4))
	btn_lv5.pressed.connect(Callable(self, "_on_choose_level").bind(5))
	btn_lv6.pressed.connect(Callable(self, "_on_choose_level").bind(6))
	btn_lv7.pressed.connect(Callable(self, "_on_choose_level").bind(7))
	btn_lv8.pressed.connect(Callable(self, "_on_choose_level").bind(8))
	btn_lv9.pressed.connect(Callable(self, "_on_choose_level").bind(9))
	btn_lv10.pressed.connect(Callable(self, "_on_choose_level").bind(10))
	btn_lv11.pressed.connect(Callable(self, "_on_choose_level").bind(11))
	btn_lv12.pressed.connect(Callable(self, "_on_choose_level").bind(12))


func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv - 1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/StartUI.tscn")


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel2.tscn")

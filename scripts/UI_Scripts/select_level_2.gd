extends Control

@onready var btn_lv13: Button = $LevelMenu/btnlv13
@onready var btn_lv14: Button = $LevelMenu/btnlv14
@onready var btn_lv15: Button = $LevelMenu/btnlv15
@onready var btn_lv16: Button = $LevelMenu/btnlv16
@onready var btn_lv17: Button = $LevelMenu/btnlv17
@onready var btn_lv18: Button = $LevelMenu/btnlv18
@onready var btn_lv19: Button = $LevelMenu/btnlv19
@onready var btn_lv20: Button = $LevelMenu/btnlv20
@onready var btn_lv21: Button = $LevelMenu/btnlv21
@onready var btn_lv22: Button = $LevelMenu/btnlv22
@onready var btn_lv23: Button = $LevelMenu/btnlv23
@onready var btn_lv24: Button = $LevelMenu/btnlv24

@onready var lock13: TextureRect = $LevelMenu/btnlv13/lock13 if $LevelMenu/btnlv13.has_node("lock13") else null
@onready var lock14: TextureRect = $LevelMenu/btnlv14/lock14 if $LevelMenu/btnlv14.has_node("lock14") else null
@onready var lock15: TextureRect = $LevelMenu/btnlv15/lock15 if $LevelMenu/btnlv15.has_node("lock15") else null
@onready var lock16: TextureRect = $LevelMenu/btnlv16/lock16 if $LevelMenu/btnlv16.has_node("lock16") else null
@onready var lock17: TextureRect = $LevelMenu/btnlv17/lock17 if $LevelMenu/btnlv17.has_node("lock17") else null
@onready var lock18: TextureRect = $LevelMenu/btnlv18/lock18 if $LevelMenu/btnlv18.has_node("lock18") else null
@onready var lock19: TextureRect = $LevelMenu/btnlv19/lock19 if $LevelMenu/btnlv19.has_node("lock19") else null
@onready var lock20: TextureRect = $LevelMenu/btnlv20/lock20 if $LevelMenu/btnlv20.has_node("lock20") else null
@onready var lock21: TextureRect = $LevelMenu/btnlv21/lock21 if $LevelMenu/btnlv21.has_node("lock21") else null
@onready var lock22: TextureRect = $LevelMenu/btnlv22/lock22 if $LevelMenu/btnlv22.has_node("lock22") else null
@onready var lock23: TextureRect = $LevelMenu/btnlv23/lock23 if $LevelMenu/btnlv23.has_node("lock23") else null
@onready var lock24: TextureRect = $LevelMenu/btnlv24/lock24 if $LevelMenu/btnlv24.has_node("lock24") else null

func _ready() -> void:
	btn_lv13.disabled = not GameData.is_stage_unlocked(12)
	if lock13:
		lock13.visible = not GameData.is_stage_unlocked(12)

	btn_lv14.disabled = not GameData.is_stage_unlocked(13)
	if lock14:
		lock14.visible = not GameData.is_stage_unlocked(13)

	btn_lv15.disabled = not GameData.is_stage_unlocked(14)
	if lock15:
		lock15.visible = not GameData.is_stage_unlocked(14)

	btn_lv16.disabled = not GameData.is_stage_unlocked(15)
	if lock16:
		lock16.visible = not GameData.is_stage_unlocked(15)

	btn_lv17.disabled = not GameData.is_stage_unlocked(16)
	if lock17:
		lock17.visible = not GameData.is_stage_unlocked(16)

	btn_lv18.disabled = not GameData.is_stage_unlocked(17)
	if lock18:
		lock18.visible = not GameData.is_stage_unlocked(17)

	btn_lv19.disabled = not GameData.is_stage_unlocked(18)
	if lock19:
		lock19.visible = not GameData.is_stage_unlocked(18)

	btn_lv20.disabled = not GameData.is_stage_unlocked(19)
	if lock20:
		lock20.visible = not GameData.is_stage_unlocked(19)

	btn_lv21.disabled = not GameData.is_stage_unlocked(20)
	if lock21:
		lock21.visible = not GameData.is_stage_unlocked(20)

	btn_lv22.disabled = not GameData.is_stage_unlocked(21)
	if lock22:
		lock22.visible = not GameData.is_stage_unlocked(21)

	btn_lv23.disabled = not GameData.is_stage_unlocked(22)
	if lock23:
		lock23.visible = not GameData.is_stage_unlocked(22)

	btn_lv24.disabled = not GameData.is_stage_unlocked(23)
	if lock24:
		lock24.visible = not GameData.is_stage_unlocked(23)
		#connect button
		
	btn_lv13.pressed.connect(Callable(self, "_on_choose_level").bind(13))
	btn_lv14.pressed.connect(Callable(self, "_on_choose_level").bind(14))
	btn_lv15.pressed.connect(Callable(self, "_on_choose_level").bind(15))
	btn_lv16.pressed.connect(Callable(self, "_on_choose_level").bind(16))
	btn_lv17.pressed.connect(Callable(self, "_on_choose_level").bind(17))
	btn_lv18.pressed.connect(Callable(self, "_on_choose_level").bind(18))
	btn_lv19.pressed.connect(Callable(self, "_on_choose_level").bind(19))
	btn_lv20.pressed.connect(Callable(self, "_on_choose_level").bind(20))
	btn_lv21.pressed.connect(Callable(self, "_on_choose_level").bind(21))
	btn_lv22.pressed.connect(Callable(self, "_on_choose_level").bind(22))
	btn_lv23.pressed.connect(Callable(self, "_on_choose_level").bind(23))
	btn_lv24.pressed.connect(Callable(self, "_on_choose_level").bind(24))

func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv - 1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)


func _on_any_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/ComingSoon.tscn")


func _on_btn_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel.tscn")
	
func _on_btn_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel3.tscn")

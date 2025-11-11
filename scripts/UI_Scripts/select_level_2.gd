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

# @onready var lock13: TextureRect = $btnlv13/lock13
# @onready var lock14: TextureRect = $btnlv14/lock14
# @onready var lock15: TextureRect = $btnlv15/lock15
# @onready var lock16: TextureRect = $btnlv16/lock16
# @onready var lock17: TextureRect = $btnlv17/lock17
# @onready var lock18: TextureRect = $btnlv18/lock18
# @onready var lock19: TextureRect = $btnlv19/lock19
# @onready var lock20: TextureRect = $btnlv20/lock20
# @onready var lock21: TextureRect = $btnlv21/lock21


func _ready() -> void:
	btn_lv13.pressed.connect(func(): _on_choose_level(13))
	btn_lv14.pressed.connect(func(): _on_choose_level(14))
	btn_lv15.pressed.connect(func(): _on_choose_level(15))
	btn_lv16.pressed.connect(func(): _on_choose_level(16))
	btn_lv17.pressed.connect(func(): _on_choose_level(17))
	btn_lv18.pressed.connect(func(): _on_choose_level(18))
	btn_lv19.pressed.connect(func(): _on_choose_level(19))
	btn_lv20.pressed.connect(func(): _on_choose_level(20))
	btn_lv21.pressed.connect(func(): _on_choose_level(21))

	btn_lv22.pressed.connect(func(): _on_choose_level(22))
	btn_lv23.pressed.connect(func(): _on_choose_level(23))
	btn_lv24.pressed.connect(func(): _on_choose_level(24))


func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv - 1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)


func _on_any_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/ComingSoon.tscn")


func _on_btn_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel.tscn")
	
func _on_btn_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel3.tscn")

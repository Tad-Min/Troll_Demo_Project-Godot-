extends Control
@onready var btn_lv13: Button = $LevelMenu/btnlv25
func _ready() -> void:
	btn_lv13.pressed.connect(func(): _on_choose_level(25))
func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv - 1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)
func _on_btn_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel2.tscn")

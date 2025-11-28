extends Control
@onready var btn_lv25: Button = $LevelMenu/btnlv25
@onready var btn_lv26: Button = $LevelMenu/btnlv26
@onready var btn_lv27: Button = $LevelMenu/btnlv27
@onready var btn_lv28: Button = $LevelMenu/btnlv28
@onready var btn_lv29: Button = $LevelMenu/btnlv29
@onready var btn_lv30: Button = $LevelMenu/btnlv30
@onready var btn_lv31: Button = $LevelMenu/btnlv31
@onready var btn_lv32: Button = $LevelMenu/btnlv32
@onready var btn_lv33: Button = $LevelMenu/btnlv33
@onready var btn_lv34: Button = $LevelMenu/btnlv34
@onready var btn_lv35: Button = $LevelMenu/btnlv35
@onready var btn_lv36: Button = $LevelMenu/btnlv36
func _ready() -> void:
	btn_lv25.pressed.connect(func(): _on_choose_level(25))
	btn_lv26.pressed.connect(func(): _on_choose_level(26))
<<<<<<< Updated upstream
	btn_lv27.pressed.connect(_on_any_button_pressed)
	btn_lv28.pressed.connect(_on_any_button_pressed)
	btn_lv29.pressed.connect(func(): _on_choose_level(29))
	btn_lv30.pressed.connect(_on_any_button_pressed)
	btn_lv31.pressed.connect(_on_any_button_pressed)
	btn_lv32.pressed.connect(_on_any_button_pressed)
	btn_lv33.pressed.connect(_on_any_button_pressed)
	btn_lv34.pressed.connect(_on_any_button_pressed)
	btn_lv35.pressed.connect(_on_any_button_pressed)
	btn_lv36.pressed.connect(_on_any_button_pressed)
=======
	btn_lv27.pressed.connect(func(): _on_choose_level(27))
	btn_lv28.pressed.connect(func(): _on_choose_level(28))
	btn_lv29.pressed.connect(func(): _on_choose_level(29))
	btn_lv30.pressed.connect(func(): _on_choose_level(30))
	btn_lv31.pressed.connect(func(): _on_choose_level(31))
	btn_lv32.pressed.connect(func(): _on_choose_level(32))
	btn_lv33.pressed.connect(func(): _on_choose_level(33))
	btn_lv34.pressed.connect(func(): _on_choose_level(34))
	btn_lv35.pressed.connect(func(): _on_choose_level(35))
	btn_lv36.pressed.connect(func(): _on_choose_level(36))
>>>>>>> Stashed changes
func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv - 1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)
func _on_any_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/ComingSoon.tscn")

func _on_btn_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel2.tscn")
func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel4.tscn")

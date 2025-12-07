extends Control
@onready var btn_lv37: Button = $LevelMenu/btnlv37
@onready var btn_lv38: Button = $LevelMenu/btnlv38
@onready var btn_lv39: Button = $LevelMenu/btnlv39
@onready var btn_lv40: Button = $LevelMenu/btnlv40
@onready var btn_lv41: Button = $LevelMenu/btnlv41
@onready var btn_lv42: Button = $LevelMenu/btnlv42
@onready var btn_lv43: Button = $LevelMenu/btnlv43
@onready var btn_lv44: Button = $LevelMenu/btnlv44
@onready var btn_lv45: Button = $LevelMenu/btnlv45
@onready var btn_lv46: Button = $LevelMenu/btnlv46
<<<<<<< Updated upstream
@onready var btn_lv47: Button = $LevelMenu/btnlv47
@onready var btn_lv48: Button = $LevelMenu/btnlv48
=======
@onready var key_label: Label = $LevelMenu/KeyLabel

>>>>>>> Stashed changes
func _ready() -> void:
	btn_lv37.pressed.connect(func(): _on_choose_level(37))
<<<<<<< Updated upstream
	btn_lv38.pressed.connect(_on_any_button_pressed)
	btn_lv39.pressed.connect(_on_any_button_pressed)
	btn_lv40.pressed.connect(_on_any_button_pressed)
	btn_lv41.pressed.connect(_on_any_button_pressed)
	btn_lv42.pressed.connect(_on_any_button_pressed)
	btn_lv43.pressed.connect(_on_any_button_pressed)
	btn_lv44.pressed.connect(_on_any_button_pressed)
	btn_lv45.pressed.connect(_on_any_button_pressed)
	btn_lv46.pressed.connect(_on_any_button_pressed)
	btn_lv47.pressed.connect(_on_any_button_pressed)
	btn_lv48.pressed.connect(_on_any_button_pressed)
=======
	btn_lv38.pressed.connect(func(): _on_choose_level(38))
	btn_lv39.pressed.connect(func(): _on_choose_level(39))
	btn_lv40.pressed.connect(func(): _on_choose_level(40))
	btn_lv41.pressed.connect(func(): _on_choose_level(41))
	btn_lv42.pressed.connect(func(): _on_choose_level(42))
	btn_lv43.pressed.connect(func(): _on_choose_level(43))
	btn_lv44.pressed.connect(func(): _on_choose_level(44))
	btn_lv45.pressed.connect(func(): _on_choose_level(45))
	btn_lv46.pressed.connect(_on_lv46_button_pressed)
>>>>>>> Stashed changes
func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv - 1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)
func _on_any_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/ComingSoon.tscn")

func _on_btn_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel2.tscn")

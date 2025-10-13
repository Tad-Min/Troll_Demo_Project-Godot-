extends Control
@onready var btn_return: Button = $btnReturn
@onready var btn_lv13: Button = $btnlv13
@onready var btn_lv14: Button = $btnlv14
@onready var btn_lv15: Button = $btnlv15
@onready var btn_lv16: Button = $btnlv16
@onready var btn_lv17: Button = $btnlv17
@onready var btn_lv18: Button = $btnlv18
@onready var btn_lv19: Button = $btnlv19

@onready var lock13: TextureRect = $btnlv13/lock13
@onready var lock14: TextureRect = $btnlv14/lock14
@onready var lock15: TextureRect = $btnlv15/lock15
@onready var lock16: TextureRect = $btnlv15/lock16
@onready var lock17: TextureRect = $btnlv17/lock17
@onready var lock18: TextureRect = $btnlv18/lock18
@onready var lock19: TextureRect = $btnlv18/lock19
func _ready():
	
	
	btn_lv13.pressed.connect(func(): _on_choose_level(13))
	btn_lv14.pressed.connect(func(): _on_choose_level(14))
	btn_lv15.pressed.connect(func(): _on_choose_level(15))
	btn_lv16.pressed.connect(func(): _on_choose_level(16))
	btn_lv17.pressed.connect(func(): _on_choose_level(17))
	btn_lv18.pressed.connect(func(): _on_choose_level(18))
	btn_lv19.pressed.connect(func(): _on_choose_level(19))
	btn_return.pressed.connect(_on_btn_return_pressed)
	
func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv-1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)

func _on_btn_return_pressed(): get_tree().change_scene_to_file("res://scenes/SelectLevel.tscn")

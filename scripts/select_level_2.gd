extends Control
@onready var btn_return: Button = $btnReturn
@onready var btn_lv13: Button = $btnlv13
@onready var btn_lv14: Button = $btnlv14
@onready var btn_lv15: Button = $btnlv15

@onready var lock13: TextureRect = $btnlv13/lock13
@onready var lock14: TextureRect = $btnlv14/lock14
@onready var lock15: TextureRect = $btnlv15/lock15
func _ready():
	
	
	btn_lv13.pressed.connect(func(): _on_choose_level(13))
	btn_lv14.pressed.connect(func(): _on_choose_level(14))
	btn_lv15.pressed.connect(func(): _on_choose_level(15))
	
	
func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv-1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)

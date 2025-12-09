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
#lock
@onready var lock25: TextureRect = $LevelMenu/btnlv25/lock25 if $LevelMenu/btnlv25.has_node("lock25") else null
@onready var lock26: TextureRect = $LevelMenu/btnlv26/lock26 if $LevelMenu/btnlv26.has_node("lock26") else null
@onready var lock27: TextureRect = $LevelMenu/btnlv27/lock27 if $LevelMenu/btnlv27.has_node("lock27") else null
@onready var lock28: TextureRect = $LevelMenu/btnlv28/lock28 if $LevelMenu/btnlv28.has_node("lock28") else null
@onready var lock29: TextureRect = $LevelMenu/btnlv29/lock29 if $LevelMenu/btnlv29.has_node("lock29") else null
@onready var lock30: TextureRect = $LevelMenu/btnlv30/lock30 if $LevelMenu/btnlv30.has_node("lock30") else null
@onready var lock31: TextureRect = $LevelMenu/btnlv31/lock31 if $LevelMenu/btnlv31.has_node("lock31") else null
@onready var lock32: TextureRect = $LevelMenu/btnlv32/lock32 if $LevelMenu/btnlv32.has_node("lock32") else null
@onready var lock33: TextureRect = $LevelMenu/btnlv33/lock33 if $LevelMenu/btnlv33.has_node("lock33") else null
@onready var lock34: TextureRect = $LevelMenu/btnlv34/lock34 if $LevelMenu/btnlv34.has_node("lock34") else null
@onready var lock35: TextureRect = $LevelMenu/btnlv35/lock35 if $LevelMenu/btnlv35.has_node("lock35") else null
@onready var lock36: TextureRect = $LevelMenu/btnlv36/lock36 if $LevelMenu/btnlv36.has_node("lock36") else null

func _ready() -> void:
	#logic
	btn_lv25.disabled = not GameData.is_stage_unlocked(24)
	if $LevelMenu/btnlv25.has_node("lock25"):
		$LevelMenu/btnlv25/lock25.visible = not GameData.is_stage_unlocked(24)

	btn_lv26.disabled = not GameData.is_stage_unlocked(25)
	if $LevelMenu/btnlv26.has_node("lock26"):
		$LevelMenu/btnlv26/lock26.visible = not GameData.is_stage_unlocked(25)

	btn_lv27.disabled = not GameData.is_stage_unlocked(26)
	if $LevelMenu/btnlv27.has_node("lock27"):
		$LevelMenu/btnlv27/lock27.visible = not GameData.is_stage_unlocked(26)

	btn_lv28.disabled = not GameData.is_stage_unlocked(27)
	if $LevelMenu/btnlv28.has_node("lock28"):
		$LevelMenu/btnlv28/lock28.visible = not GameData.is_stage_unlocked(27)

	btn_lv29.disabled = not GameData.is_stage_unlocked(28)
	if $LevelMenu/btnlv29.has_node("lock29"):
		$LevelMenu/btnlv29/lock29.visible = not GameData.is_stage_unlocked(28)

	btn_lv30.disabled = not GameData.is_stage_unlocked(29)
	if $LevelMenu/btnlv30.has_node("lock30"):
		$LevelMenu/btnlv30/lock30.visible = not GameData.is_stage_unlocked(29)

	btn_lv31.disabled = not GameData.is_stage_unlocked(30)
	if $LevelMenu/btnlv31.has_node("lock31"):
		$LevelMenu/btnlv31/lock31.visible = not GameData.is_stage_unlocked(30)

	btn_lv32.disabled = not GameData.is_stage_unlocked(31)
	if $LevelMenu/btnlv32.has_node("lock32"):
		$LevelMenu/btnlv32/lock32.visible = not GameData.is_stage_unlocked(31)

	btn_lv33.disabled = not GameData.is_stage_unlocked(32)
	if $LevelMenu/btnlv33.has_node("lock33"):
		$LevelMenu/btnlv33/lock33.visible = not GameData.is_stage_unlocked(32)

	btn_lv34.disabled = not GameData.is_stage_unlocked(33)
	if $LevelMenu/btnlv34.has_node("lock34"):
		$LevelMenu/btnlv34/lock34.visible = not GameData.is_stage_unlocked(33)

	btn_lv35.disabled = not GameData.is_stage_unlocked(34)
	if $LevelMenu/btnlv35.has_node("lock35"):
		$LevelMenu/btnlv35/lock35.visible = not GameData.is_stage_unlocked(34)

	btn_lv36.disabled = not GameData.is_stage_unlocked(35)
	if $LevelMenu/btnlv36.has_node("lock36"):
		$LevelMenu/btnlv36/lock36.visible = not GameData.is_stage_unlocked(35)
  #connect
	btn_lv25.pressed.connect(func(): _on_choose_level(25))
	btn_lv26.pressed.connect(func(): _on_choose_level(26))
<<<<<<< Updated upstream
	btn_lv27.pressed.connect(_on_any_button_pressed)
	btn_lv28.pressed.connect(_on_any_button_pressed)
	btn_lv29.pressed.connect(_on_any_button_pressed)
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

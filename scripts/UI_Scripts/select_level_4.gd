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
@onready var key_label: Label = $LevelMenu/KeyLabel

#lock
@onready var lock37: TextureRect = $LevelMenu/btnlv37/lock37 if $LevelMenu/btnlv37.has_node("lock37") else null
@onready var lock38: TextureRect = $LevelMenu/btnlv38/lock38 if $LevelMenu/btnlv38.has_node("lock38") else null
@onready var lock39: TextureRect = $LevelMenu/btnlv39/lock39 if $LevelMenu/btnlv39.has_node("lock39") else null
@onready var lock40: TextureRect = $LevelMenu/btnlv40/lock40 if $LevelMenu/btnlv40.has_node("lock40") else null
@onready var lock41: TextureRect = $LevelMenu/btnlv41/lock41 if $LevelMenu/btnlv41.has_node("lock41") else null
@onready var lock42: TextureRect = $LevelMenu/btnlv42/lock42 if $LevelMenu/btnlv42.has_node("lock42") else null
@onready var lock43: TextureRect = $LevelMenu/btnlv43/lock43 if $LevelMenu/btnlv43.has_node("lock43") else null
@onready var lock44: TextureRect = $LevelMenu/btnlv44/lock44 if $LevelMenu/btnlv44.has_node("lock44") else null
@onready var lock45: TextureRect = $LevelMenu/btnlv45/lock45 if $LevelMenu/btnlv45.has_node("lock45") else null


const LOCK_ICON = preload("res://assets/Jungle Asset Pack/parallax background/LockScreen.png")

var _original_skull_icon: AnimatedTexture = null

func _ready() -> void:
	btn_lv37.disabled = not GameData.is_stage_unlocked(36)
	if $LevelMenu/btnlv37.has_node("lock37"):
		$LevelMenu/btnlv37/lock37.visible = not GameData.is_stage_unlocked(36)

	btn_lv38.disabled = not GameData.is_stage_unlocked(37)
	if $LevelMenu/btnlv38.has_node("lock38"):
		$LevelMenu/btnlv38/lock38.visible = not GameData.is_stage_unlocked(37)

	btn_lv39.disabled = not GameData.is_stage_unlocked(38)
	if $LevelMenu/btnlv39.has_node("lock39"):
		$LevelMenu/btnlv39/lock39.visible = not GameData.is_stage_unlocked(38)

	btn_lv40.disabled = not GameData.is_stage_unlocked(39)
	if $LevelMenu/btnlv40.has_node("lock40"):
		$LevelMenu/btnlv40/lock40.visible = not GameData.is_stage_unlocked(39)

	btn_lv41.disabled = not GameData.is_stage_unlocked(40)
	if $LevelMenu/btnlv41.has_node("lock41"):
		$LevelMenu/btnlv41/lock41.visible = not GameData.is_stage_unlocked(40)

	btn_lv42.disabled = not GameData.is_stage_unlocked(41)
	if $LevelMenu/btnlv42.has_node("lock42"):
		$LevelMenu/btnlv42/lock42.visible = not GameData.is_stage_unlocked(41)

	btn_lv43.disabled = not GameData.is_stage_unlocked(42)
	if $LevelMenu/btnlv43.has_node("lock43"):
		$LevelMenu/btnlv43/lock43.visible = not GameData.is_stage_unlocked(42)

	btn_lv44.disabled = not GameData.is_stage_unlocked(43)
	if $LevelMenu/btnlv44.has_node("lock44"):
		$LevelMenu/btnlv44/lock44.visible = not GameData.is_stage_unlocked(43)

	btn_lv45.disabled = not GameData.is_stage_unlocked(44)
	if $LevelMenu/btnlv45.has_node("lock45"):
		$LevelMenu/btnlv45/lock45.visible = not GameData.is_stage_unlocked(44)

	# Save original skull icon
	if btn_lv46.icon is AnimatedTexture:
		_original_skull_icon = btn_lv46.icon as AnimatedTexture
	else:
		# Create AnimatedTexture if not already set
		var skull_texture = preload("res://assets/skull/1.png")
		var skull_texture2 = preload("res://assets/skull/2.png")
		_original_skull_icon = AnimatedTexture.new()
		_original_skull_icon.frames = 2
		_original_skull_icon.set_frame_texture(0, skull_texture)
		_original_skull_icon.set_frame_texture(1, skull_texture2)
		_original_skull_icon.set_frame_duration(1, 1.0)
	
	_update_lv46_unlock_status()
	btn_lv37.pressed.connect(func(): _on_choose_level(37))
	btn_lv38.pressed.connect(func(): _on_choose_level(38))
	btn_lv39.pressed.connect(func(): _on_choose_level(39))
	btn_lv40.pressed.connect(func(): _on_choose_level(40))
	btn_lv41.pressed.connect(func(): _on_choose_level(41))
	btn_lv42.pressed.connect(func(): _on_choose_level(42))
	btn_lv43.pressed.connect(func(): _on_choose_level(43))
	btn_lv44.pressed.connect(func(): _on_choose_level(44))
	btn_lv45.pressed.connect(func(): _on_choose_level(45))
	btn_lv46.pressed.connect(_on_lv46_button_pressed)

func _on_choose_level(lv: int) -> void:
	GameData.current_level = lv - 1
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % lv)
func _on_any_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/ComingSoon.tscn")

func _update_lv46_unlock_status() -> void:
	var can_unlock = GameData.can_unlock_lv46()
	btn_lv46.disabled = not can_unlock
	
	# Update icon: show skull when enabled, hide icon when disabled (button is already lock)
	if can_unlock:
		# Restore skull icon (AnimatedTexture)
		if _original_skull_icon:
			btn_lv46.icon = _original_skull_icon
			btn_lv46.modulate = Color.WHITE  # Ensure full opacity
	else:
		# Hide icon since button style is already lock
		btn_lv46.icon = null
		btn_lv46.modulate = Color.WHITE  # Ensure full opacity
	
	# Update key label
	if key_label:
		key_label.text = "Keys: %d/%d" % [GameData.keys_collected, GameData.keys_required_for_lv46]
		if can_unlock:
			key_label.modulate = Color.GREEN
		else:
			key_label.modulate = Color.RED

func _on_lv46_button_pressed() -> void:
	if GameData.can_unlock_lv46():
		_on_choose_level(46)
	else:
		# Show message or do nothing
		pass

func _on_reset_keys_pressed() -> void:
	GameData.reset_keys()
	_update_lv46_unlock_status()
	print("Keys reset! Current keys: ", GameData.keys_collected)

func _on_btn_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel2.tscn")

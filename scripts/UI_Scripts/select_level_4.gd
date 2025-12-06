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

const LOCK_ICON = preload("res://assets/Jungle Asset Pack/parallax background/LockScreen.png")

var _original_skull_icon: AnimatedTexture = null

func _ready() -> void:
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
			key_label.modulate = Color.WHITE

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

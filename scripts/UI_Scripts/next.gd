extends Control

@onready var btn_next: TextureButton = $BtnNext
@onready var btn_restart: TextureButton = $BtnRestart
@onready var btn_home: TextureButton = $BtnHome
@onready var admob = $Admob

# --- Dòng thêm: đường dẫn scene UnlockBoss ---
const UNLOCK_BOSS_SCENE := "res://scenes/GameSceneUI/UnlockBoss.tscn"
const THANKYOU_SCENE := "res://scenes/GameSceneUI/ThankYou.tscn"

var is_initialized: bool = false

func _ready() -> void:
	btn_next.pressed.connect(_on_btn_next_pressed)
	btn_restart.pressed.connect(_on_btn_restart_pressed)
	btn_home.pressed.connect(_on_btn_home_pressed)
	# AdMob init (đơn giản giống admob.gd)
	if admob:
		admob.connect("initialization_completed", Callable(self, "_on_admob_initialization_completed"))
		admob.initialize()

func _on_btn_next_pressed() -> void:
	if admob and is_initialized:
		admob.load_interstitial_ad()
		await admob.interstitial_ad_loaded
		admob.show_interstitial_ad()
		await admob.interstitial_ad_dismissed_full_screen_content

	
	if GameData.current_level == 45:
		GameData.next_level = GameData.current_level + 1
		get_tree().change_scene_to_file(UNLOCK_BOSS_SCENE)
		return
	if GameData.current_level == 46:
		get_tree().change_scene_to_file(THANKYOU_SCENE)
		return
	

	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % (GameData.current_level+1))

func _on_admob_initialization_completed(_status_data) -> void:
	is_initialized = true

func _on_btn_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/StartUI.tscn")

func _on_btn_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % (GameData.current_level))

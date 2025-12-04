extends Control

@onready var death_label: Label = %DeathLabel
@onready var cause_label: Label = %CauseLabel
@onready var admob = $Admob

var is_initialized: bool = false

func _ready() -> void:
	if death_label:
		death_label.text = "Death: %d times" % GameData.Levels[GameData.current_level].countDie
		GameData.save_progress()
	else:
		push_error("DeathLabel is null. Check node path or scene structure.")
	if cause_label:
		var readable = _format_cause(GameData.last_death_cause)
		cause_label.text = "Cause: %s" % readable
	else:
		push_error("CauseLabel is null. Add Label/ CauseLabel in GameOver scene.")

	# AdMob setup
	if admob:
		admob.connect("initialization_completed", Callable(self, "_on_admob_initialization_completed"))
		admob.initialize()

func _on_admob_initialization_completed(_status_data) -> void:
	is_initialized = true

func _pressed():
	# Check if we should show ad (every 10 deaths)
	if admob and is_initialized and GameData.total_deaths > 0 and GameData.total_deaths % 10 == 0:
		print("Showing death ad (death #", GameData.total_deaths, ")")
		admob.load_interstitial_ad()
		await admob.interstitial_ad_loaded
		admob.show_interstitial_ad()
		await admob.interstitial_ad_dismissed_full_screen_content
	
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % (GameData.current_level + 1))


func _format_cause(cause: String) -> String:
	match cause:
		"button":
			return "Pressed the forbidden button"
		"trap":
			return "Killed by a trap"
		"fell_out":
			return "Fell out of the world"
		_:
			return "Deaths will make you smarter"


func _on_btn_home_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/GameSceneUI/StartUI.tscn")

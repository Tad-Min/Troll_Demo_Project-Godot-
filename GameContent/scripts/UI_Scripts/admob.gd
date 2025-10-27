extends Node2D

@onready var admob = $Admob

var is_initialized : bool = false

func _ready():
	admob.initialize()


func _on_interstitial_pressed() -> void:
	if is_initialized:
		admob.load_interstitial_ad()
		await admob.interstitial_ad_loaded
		admob.show_interstitial_ad()


func _on_admob_initialization_completed(status_data: InitializationStatus) -> void:
	is_initialized = true

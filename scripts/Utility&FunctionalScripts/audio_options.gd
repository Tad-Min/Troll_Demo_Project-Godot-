extends Control
func _ready():
	$VBoxContainer/MasterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	$VBoxContainer/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	$VBoxContainer/SFXSlider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	



func _on_master_slider_mouse_exited():
	release_focus() # Replace with function body.



func _on_music_slider_mouse_exited():
	release_focus()# Replace with function body.



func _on_sfx_slider_mouse_exited():
	release_focus() # Replace with function body.



func _on_confirm_pressed():
	AudioServer.set_bus_volume_db(0, linear_to_db($VBoxContainer/MasterSlider.value))
	AudioServer.set_bus_volume_db(1, linear_to_db($VBoxContainer/MusicSlider.value))
	AudioServer.set_bus_volume_db(2, linear_to_db($VBoxContainer/SFXSlider.value))
	get_tree().paused = false
	self.visible = false

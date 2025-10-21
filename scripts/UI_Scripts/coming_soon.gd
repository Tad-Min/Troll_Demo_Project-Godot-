extends Control


func _on_back_button_pressed() -> void:
	print("Back button clicked!")
	get_tree().change_scene_to_file("res://scenes/GameSceneUI/SelectLevel2.tscn")

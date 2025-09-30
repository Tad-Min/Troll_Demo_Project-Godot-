extends Control

@onready var btn_next: Button = $BtnNext

func _ready() -> void:
	btn_next.pressed.connect(_on_btn_next_pressed)

func _on_btn_next_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level/Lv%d.tscn" % (GameData.current_level+1))

extends Control

@onready var btn_next: Button = $BtnNext

func _ready() -> void:
	btn_next.pressed.connect(_on_btn_next_pressed)


func _on_btn_next_pressed() -> void:
	if GameData.next_level_path != "":
		get_tree().change_scene_to_file(GameData.next_level_path)
	else:
		push_error("❌ Không có đường dẫn level tiếp theo trong GameData!")

extends Node2D

signal player_entered

@export var next_level_path: String
@export var stage_to_unlock: int

func _ready() -> void:
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	print("portal ready")
	$AnimatedSprite2D.play("idle")

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		return
	print("Player entered the portal!")
	emit_signal("player_entered")
	if stage_to_unlock > 0:      # Đảm bảo không unlock lv1
		GameData.unlock_stage(stage_to_unlock)
	# Nếu GameData đã thiết lập level kế tiếp, mở UI Next
	if GameData.next_level_path != "":
		call_deferred("_request_scene_change", "res://scenes/Next.tscn")
		return
	# Fallback: nếu không dùng UI Next, có thể chuyển thẳng
	if next_level_path != "":
		call_deferred("_request_scene_change", next_level_path)


# Yêu cầu đổi scene an toàn, kể cả khi get_tree() tạm thời null
func _request_scene_change(path: String) -> void:
	var tree := Engine.get_main_loop()
	if tree is SceneTree:
		tree.call_deferred("change_scene_to_file", path)
	else:
		push_error("Not found SceneTree to change Scene" + path)
	

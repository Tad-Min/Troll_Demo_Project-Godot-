extends Area2D

@export var is_real: bool = false
@export var portal_scene: PackedScene
@export var linked_portal: NodePath
@onready var marker: Marker2D = $Marker2D

# update working portal functions
signal player_entered
@export var next_level_path: String
@export var stage_to_unlock: int

# Lấy PortalManager trong scene
func get_manager() -> Node:
	return get_tree().current_scene.get_node("PortalManager")

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	print("PORTAL :")
	print(next_level_path)

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return

	var manager = get_manager()

	if is_real:
		get_tree().change_scene_to_file("res://scenes/Next.tscn")
		emit_signal("player_entered")
		if stage_to_unlock > 0:      # Đảm bảo không unlock lv1
			GameData.unlock_stage(stage_to_unlock)
		# Nếu GameData đã thiết lập level kế tiếp, mở UI Next
		if GameData.next_level_path != "":
			call_deferred("_request_scene_change", "res://scenes/Next.tscn")
			return
		# Fallback: nếu không dùng UI Next, có thể chuyển thẳng
		if next_level_path != "":
			GameData.next_level_path = next_level_path
			call_deferred("_request_scene_change", "res://scenes/Next.tscn")
			return
		else:
			print("next level path is null")
			print(next_level_path)
		
	else:
		# Cổng giả: spawn portal tiếp theo
		if portal_scene:
			var new_portal = portal_scene.instantiate()
			new_portal.next_level_path = next_level_path
			new_portal.stage_to_unlock = stage_to_unlock
			get_tree().current_scene.add_child(new_portal)

			if manager.portal1_position == Vector2.ZERO:
				# Đây là cổng 1 → lưu vị trí
				manager.portal1_position = global_position
				new_portal.global_position = marker.global_position
			else:
				# Đây là cổng 2 → spawn cổng thật tại vị trí cổng 1
				new_portal.global_position = manager.portal1_position

		queue_free()   # Xóa portal giả
		
# Yêu cầu đổi scene an toàn, kể cả khi get_tree() tạm thời null
func _request_scene_change(path: String) -> void:
	var tree := Engine.get_main_loop()
	if tree is SceneTree:
		tree.call_deferred("change_scene_to_file", path)
	else:
		push_error("Not found SceneTree to change Scene" + path)
	

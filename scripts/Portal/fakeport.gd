extends Area2D

@export var is_real: bool = false
@export var portal_scene: PackedScene
@export var linked_portal: NodePath
@export var next_level: int = 0
@onready var marker: Marker2D = $Marker2D

# update working portal functions
signal player_entered

# Lấy PortalManager trong scene
func get_manager() -> Node:
	return get_tree().current_scene.get_node("PortalManager")

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return

	var manager = get_manager()

	if is_real:
		emit_signal("player_entered")
		GameData.commit_pending_keys()
		GameData.current_level = max(0, next_level - 1)
		GameData.unlock_level(GameData.current_level)
		GameData.save_progress()
		get_tree().change_scene_to_file("res://scenes/GameSceneUI/Next.tscn")
		return
		
	else:
		# Cổng giả: spawn portal tiếp theo
		if portal_scene:
			var new_portal = portal_scene.instantiate()
			# truyền tiếp cấu hình level nếu prefab dùng chung script
			if "next_level" in new_portal:
				new_portal.next_level = next_level
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
	

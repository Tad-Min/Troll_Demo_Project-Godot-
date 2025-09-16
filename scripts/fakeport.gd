extends Area2D

@export var is_real: bool = false
@export var portal_scene: PackedScene
@export var linked_portal: NodePath
@onready var marker: Marker2D = $Marker2D

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
		get_tree().change_scene_to_file("res://scenes/Level/Lv9.tscn")

		
	else:
		# Cổng giả: spawn portal tiếp theo
		if portal_scene:
			var new_portal = portal_scene.instantiate()
			get_tree().current_scene.add_child(new_portal)

			if manager.portal1_position == Vector2.ZERO:
				# Đây là cổng 1 → lưu vị trí
				manager.portal1_position = global_position
				new_portal.global_position = marker.global_position
			else:
				# Đây là cổng 2 → spawn cổng thật tại vị trí cổng 1
				new_portal.global_position = manager.portal1_position

		queue_free()   # Xóa portal giả

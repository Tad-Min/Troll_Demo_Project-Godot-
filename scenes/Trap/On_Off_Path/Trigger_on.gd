extends Area2D

@export var path_node: NodePath
@export var default: bool = false

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	var path = get_node(path_node)
	if path is TileMapLayer:
		path.collision_enabled = default
		path.visible = default
	if path is Area2D:
		path.monitoring = default
		path.monitorable = default
		
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		var path = get_node(path_node)
		print("collided")
		if path is TileMapLayer:
			path.collision_enabled = true
			path.visible = true
		if path is Area2D:
			print("enable hidden trap")
			path.monitoring = not default
			path.monitorable = not default

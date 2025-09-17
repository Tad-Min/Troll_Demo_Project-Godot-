extends Area2D

@export var path_node: NodePath

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
		
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		var path = get_node(path_node)
		if path is TileMapLayer:
			path.collision_enabled = false
			path.visible = false

extends Area2D

@export var X1: NodePath
@export var default_X1: bool = false

@export var X2: NodePath
@export var default_X2: bool = false

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
		
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		var x1 = get_node(X1)
		var x2 = get_node(X2)
		if x1 is TileMapLayer and x2 is TileMapLayer:
			x1.collision_enabled = not default_X1
			x1.visible = not default_X1
			x2.collision_enabled = not default_X2
			x2.visible = not default_X2

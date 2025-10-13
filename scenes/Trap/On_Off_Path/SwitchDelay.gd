extends Area2D

@export var X1: NodePath
@export var default_X1: bool = false

@export var X2: NodePath
@export var default_X2: bool = false

@export var delay_seconds: float = 0.0  # delay before toggling
@export var activate_limit: int = 0      # 0 = infinite activations

var activate_count: int = 0

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
		
func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		return
	
	# Check activation limit
	if activate_limit > 0 and activate_count >= activate_limit:
		return

	activate_count += 1

	var x1 = get_node(X1)
	var x2 = get_node(X2)

	if x1 is TileMapLayer and x2 is TileMapLayer:
		await get_tree().create_timer(delay_seconds).timeout
		
		x1.collision_enabled = not default_X1
		x1.visible = not default_X1

		x2.collision_enabled = not default_X2
		x2.visible = not default_X2

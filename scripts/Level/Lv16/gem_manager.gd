extends Node

@export var door_path: NodePath
@export var required_gems: int = 3

var collected_count: int = 0

func _ready() -> void:
	# Auto-wire to all normal gems in this level
	for g in get_tree().get_nodes_in_group("normal_gem"):
		if g.has_signal("collected"):
			g.connect("collected", Callable(self, "_on_gem_collected"))

func _on_gem_collected() -> void:
	collected_count += 1
	if collected_count >= required_gems:
		_open_door()

func _open_door() -> void:
	if not door_path:
		return
	var door = get_node_or_null(door_path)
	if door:
		door.queue_free()

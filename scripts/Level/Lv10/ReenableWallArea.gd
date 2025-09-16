extends Area2D

@export var Lock: NodePath
var used := false

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if used:
		return
	if body.is_in_group("Player") and Lock:
		var lock = get_node(Lock)
		if lock:
			# Only re-enable if it is currently disabled/hidden
			var is_currently_disabled := _is_wall_disabled(lock)
			if is_currently_disabled:
				used = true
				_set_wall_enabled(lock, true)

func _set_wall_enabled(node: Node, enabled: bool) -> void:
	if node == null:
		return
	if "visible" in node:
		node.set_deferred("visible", enabled)
	for child in node.get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.set_deferred("disabled", not enabled)
		_set_wall_enabled(child, enabled)

func _is_wall_disabled(node: Node) -> bool:
	var hidden := false
	if "visible" in node:
		hidden = not node.visible
	var any_shape_disabled := false
	for child in node.get_children():
		if child is CollisionShape2D and child.disabled:
			any_shape_disabled = true
			break
	return hidden or any_shape_disabled

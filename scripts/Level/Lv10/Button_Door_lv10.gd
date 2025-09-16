extends Node2D

@export var Lock: NodePath
var isActive := false

func _ready() -> void:
	if Lock: 
		$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print("Not Assign Lock yet")
func _on_body_entered(body: Node) -> void:
	if Lock and  body.is_in_group("Player") and not isActive:
		var lock = get_node(Lock)
		$AnimatedSprite2D.play("default")
		isActive = true
		_set_wall_enabled(lock, false)

func _set_wall_enabled(node: Node, enabled: bool) -> void:
	if node == null:
		return
	if "visible" in node:
		node.set_deferred("visible", enabled)
	for child in node.get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.set_deferred("disabled", not enabled)
		_set_wall_enabled(child, enabled)

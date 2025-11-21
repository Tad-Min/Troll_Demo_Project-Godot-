extends Area2D

@export var Trap_Door: NodePath
@export var start_enabled: bool = false
@export var one_shot: bool = true
@export var extra_nodes_to_enable: Array[NodePath] = []

var _target: Node = null
var _extra_targets: Array[Node] = []
var _is_active: bool = false

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	_target = get_node_or_null(Trap_Door)
	if _target:
		_set_target_active(start_enabled)
	else:
		push_warning("LayerLastTrigger: Không tìm thấy node ở đường dẫn %s" % Trap_Door)
	for path in extra_nodes_to_enable:
		var node = get_node_or_null(path)
		if node:
			_extra_targets.append(node)
			_apply_state_recursive(node, start_enabled)
		else:
			push_warning("LayerLastTrigger: Không tìm thấy extra node %s" % path)

func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		return
	if not _target:
		return
	if _is_active:
		return
	_set_target_active(true)
	if one_shot:
		queue_free()

func _set_target_active(active: bool) -> void:
	_is_active = active
	_apply_state_recursive(_target, active)
	for extra in _extra_targets:
		_apply_state_recursive(extra, active)

func _apply_state_recursive(node: Node, active: bool) -> void:
	if node == null:
		return
	if node is CanvasItem:
		node.visible = active
	if node is TileMapLayer:
		node.collision_enabled = active
	if node is Area2D:
		node.monitoring = active
		node.monitorable = active
	if node is CollisionShape2D or node is CollisionPolygon2D:
		node.set_deferred("disabled", not active)
	for child in node.get_children():
		_apply_state_recursive(child, active)

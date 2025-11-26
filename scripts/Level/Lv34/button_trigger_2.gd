extends Area2D

@export var spike_path: NodePath

var _used := false
var _spike = null

func _ready() -> void:
	body_entered.connect(_on_enter)

	if spike_path != NodePath(""):
		_spike = get_node_or_null(spike_path)
	else:
		push_warning("SpikeSimple12 path is NOT assigned!")


func _on_enter(body: Node) -> void:
	if _used: return
	if body == null or not body.is_in_group("Player"): return

	_used = true
	if _spike:
		_hide_spike(_spike)


func _hide_spike(node: Node) -> void:
	if node is CanvasItem:
		node.visible = false

	if node is Area2D:
		node.monitoring = false
		node.monitorable = false

	if node is CollisionShape2D or node is CollisionPolygon2D:
		node.set_deferred("disabled", true)

	for child in node.get_children():
		_hide_spike(child)

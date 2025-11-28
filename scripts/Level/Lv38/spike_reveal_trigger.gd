extends Area2D

@export var spike_path: NodePath

var _spike: Node2D
var _spike_area: Area2D
var _revealed := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)

	if spike_path.is_empty():
		push_warning("SpikeRevealTrigger: spike_path is empty.")
		return

	_spike = get_node_or_null(spike_path)
	if _spike == null:
		push_warning("SpikeRevealTrigger: Cannot find spike at %s" % spike_path)
		return

	_spike_area = _spike.get_node_or_null("Area2D")
	_set_spike_enabled(false)


func _on_body_entered(body: Node) -> void:
	if _revealed or not body.is_in_group("Player"):
		return

	_revealed = true
	_set_spike_enabled(true)


func _set_spike_enabled(enabled: bool) -> void:
	if _spike:
		_spike.visible = enabled
	if _spike_area:
		_spike_area.set_deferred("monitoring", enabled)
		_spike_area.set_deferred("monitorable", enabled)

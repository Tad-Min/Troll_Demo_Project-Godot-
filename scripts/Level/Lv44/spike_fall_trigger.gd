extends Area2D

@export var spike_targets: Array[NodePath] = []
@export var fall_offset: Vector2 = Vector2(0, 120)
@export var tween_duration: float = 0.4

var _has_triggered := false
var _spike_refs: Array[Node2D] = []


func _ready() -> void:
	body_entered.connect(_on_body_entered)

	for path in spike_targets:
		var spike := get_node_or_null(path)
		if spike:
			_spike_refs.append(spike)
		else:
			push_warning("SpikeFallTrigger: cannot find spike at path %s" % path)


func _on_body_entered(body: Node) -> void:
	if _has_triggered:
		return
	if body == null or not body.is_in_group("Player"):
		return

	_has_triggered = true
	_drop_spikes()


func _drop_spikes() -> void:
	for spike in _spike_refs:
		if not is_instance_valid(spike):
			continue

		var start_pos := spike.position
		var target_pos := start_pos + fall_offset

		var tween := create_tween()
		tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		tween.tween_property(spike, "position", target_pos, tween_duration)

	# Chỉ làm nhiệm vụ cho spike rơi xuống, không đụng tới tường ẩn nữa.

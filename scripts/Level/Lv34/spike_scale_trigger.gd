extends Area2D

## SpikeScaleTrigger
## VN: Khi player tiến gần, spike mục tiêu sẽ phóng to theo tỉ lệ chỉ định.
## EN: Grows the target spike to a new scale once the player enters.

@export var spike_path: NodePath
@export var target_scale: Vector2 = Vector2(7, 2)
@export var tween_duration: float = 0.35
@export var ease_type: Tween.EaseType = Tween.EASE_OUT
@export var trans_type: Tween.TransitionType = Tween.TRANS_BACK
@export var one_shot: bool = true

var _spike: Node2D
var _triggered := false
var _initial_scale: Vector2 = Vector2.ONE


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_spike = get_node_or_null(spike_path)
	if _spike:
		_initial_scale = _spike.scale
	else:
		push_warning("SpikeScaleTrigger: Không tìm thấy spike ở đường dẫn %s" % spike_path)


func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("Player"):
		return
	if _triggered and one_shot:
		return
	if not _spike:
		return

	_triggered = true
	var tween := create_tween()
	tween.set_ease(ease_type)
	tween.set_trans(trans_type)
	tween.tween_property(_spike, "scale", target_scale, tween_duration)


func reset_trigger() -> void:
	## VN: Cho phép tái sử dụng trigger nếu cần (đặt one_shot = false rồi gọi hàm này).
	## EN: Can be called to reuse the trigger when one_shot is false.
	if not _spike:
		return
	_spike.scale = _initial_scale
	_triggered = false

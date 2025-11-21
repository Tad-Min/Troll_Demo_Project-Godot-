extends Area2D

## SpikeShiftTrigger
## VN: Khi player chạm vào vùng này, các spike mục tiêu sẽ trượt sang phải để troll.
## EN: When the player touches this trigger area, the target spikes slide to the right.

@export var spike_targets: Array[NodePath] = []
	## VN: Các NodePath tới spike muốn dịch chuyển (thiết lập trong scene).
	## EN: NodePaths to the spikes we want to move (set in the scene editor).

@export var shift_offset: Vector2 = Vector2(24, 0)
	## VN: Vector dịch chuyển, mặc định 24px sang phải.
	## EN: Movement vector, defaults to 24px to the right.

@export var tween_duration: float = 0.25
	## VN: Nếu không đặt tốc độ riêng, tween sẽ dùng thời gian này.
	## EN: Base duration used when no custom speed is provided.

@export var speed_pixels_per_sec: float = 0.0
	## VN: Khi >0, thời gian tween = độ dài dịch chuyển / tốc độ này.
	## EN: When >0, tween duration becomes shift distance / this speed.

var _has_triggered := false
	## VN: Đảm bảo troll chỉ xảy ra một lần.
	## EN: Makes sure the prank only runs once.

var _spike_refs: Array[Node2D] = []
	## VN/EN: Bộ nhớ cache cho các spike thực tế để tránh phải get_node nhiều lần.


func _ready() -> void:
	## VN: Lưu lại các tham chiếu ngay khi node sẵn sàng.
	## EN: Cache every spike reference as soon as the node is ready.
	body_entered.connect(_on_body_entered)
	for path in spike_targets:
		var spike := get_node_or_null(path)
		if spike:
			_spike_refs.append(spike)
		else:
			push_warning("SpikeShiftTrigger: Không tìm thấy node cho đường dẫn %s" % path)


func _on_body_entered(body: Node) -> void:
	## VN: Chỉ phản ứng với Player và chỉ 1 lần duy nhất.
	## EN: Only react to the Player group and only once.
	if _has_triggered:
		return
	if body == null or not body.is_in_group("Player"):
		return

	_has_triggered = true
	_troll_player()


func _troll_player() -> void:
	## VN: Dùng Tween để di chuyển từng spike mục tiêu sang vị trí mới.
	## EN: Use tweens so that every target spike glides into its new position.
	var target_duration := tween_duration
	if speed_pixels_per_sec > 0.0 and shift_offset.length() > 0.0:
		target_duration = max(shift_offset.length() / speed_pixels_per_sec, 0.01)
	
	for spike in _spike_refs:
		if not is_instance_valid(spike):
			continue
		var tween := create_tween()
		tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween.tween_property(spike, "position", spike.position + shift_offset, target_duration)

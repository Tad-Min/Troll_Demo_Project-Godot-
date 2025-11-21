extends Area2D

## SpikeLaunchTrigger
## VN: Player chạm vùng này -> spike được chọn lao thẳng theo vector launch.
## EN: When the player hits this area the selected spike dashes along launch_vector.

@export var spike_target: NodePath
	## VN/EN: Đường dẫn tới spike cần troll (thiết lập trong scene).

@export var launch_vector: Vector2 = Vector2(0, -120)
	## VN: Hướng và quãng đường spike sẽ bay (mặc định bay lên 120px).
	## EN: Direction & distance of the launch (defaults to 120px upward).

@export var launch_time: float = 0.18
	## VN: Thời gian spike bay lên.
	## EN: Time it takes to reach the end of launch_vector.

@export var hold_time: float = 0.1
	## VN/EN: Thời gian giữ ở vị trí cuối (nếu trả về).

@export var return_time: float = 0.3
	## VN/EN: Thời gian rơi về vị trí ban đầu.

@export var return_after_launch: bool = true
	## VN: Nếu bật, spike sẽ tự quay về vị trí cũ sau troll.
	## EN: When true the spike automatically moves back after the prank.

var _spike: Node2D
var _original_position: Vector2
var _triggered := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_spike = get_node_or_null(spike_target)
	if _spike:
		_original_position = _spike.position
	else:
		push_warning("SpikeLaunchTrigger: Không tìm thấy node cho %s" % spike_target)


func _on_body_entered(body: Node) -> void:
	if _triggered:
		return
	if body == null or not body.is_in_group("Player"):
		return
	_triggered = true
	_launch()


func _launch() -> void:
	if not is_instance_valid(_spike):
		return
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(_spike, "position", _original_position + launch_vector, launch_time)
	if return_after_launch:
		tween.tween_interval(hold_time)
		tween.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_IN)
		tween.tween_property(_spike, "position", _original_position, return_time)

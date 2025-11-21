extends Area2D

## PushbackFloor
## VN: Sàn troll đẩy người chơi ngược chiều giống hình mẫu.
## EN: Floor area that constantly shoves the player backward.

@export var push_direction: Vector2 = Vector2.LEFT
	## VN: Hướng đẩy, mặc định sang trái (âm trục X).
	## EN: Direction of the push, defaults to left (negative X).

@export var push_speed: float = 260.0
	## VN: Vận tốc mục tiêu mà mặt sàn muốn ép người chơi đi theo.
	## EN: Target speed the floor tries to impose on the player.

@export var acceleration: float = 1800.0
	## VN: Mức tăng tốc để đạt tới vận tốc mục tiêu (càng lớn đẩy càng mạnh).
	## EN: How fast we ease toward the target velocity (higher = snappier).

@export var instant_kick_speed: float = 0.0
	## VN: Tốc độ cộng thêm ngay khi player bước vào (giúp tạo cú hất mạnh).
	## EN: One-time impulse applied on entry to imitate a sudden kick.

@export var require_ground_contact: bool = true
	## VN: Chỉ đẩy khi player đang đứng trên sàn (tránh hút khi đang bay).
	## EN: Only apply push while the player is grounded on the floor.

var _bodies: Array[CharacterBody2D] = []


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(delta: float) -> void:
	var dir := push_direction.normalized()
	if dir == Vector2.ZERO:
		return
	var target_velocity := dir * push_speed
	var i := 0
	while i < _bodies.size():
		var body := _bodies[i]
		if not _is_valid_body(body):
			if body in _bodies:
				_release_body(body)
			_bodies.remove_at(i)
			continue
		body.set_pushback_force(target_velocity, acceleration, require_ground_contact)
		i += 1


func _on_body_entered(body: Node) -> void:
	if not _is_valid_body(body):
		return
	if body not in _bodies:
		_bodies.append(body)
	var dir := push_direction.normalized()
	if dir == Vector2.ZERO:
		return
	if instant_kick_speed != 0.0:
		body.apply_pushback_impulse(dir * instant_kick_speed)
	body.set_pushback_force(dir * push_speed, acceleration, require_ground_contact)


func _on_body_exited(body: Node) -> void:
	if body in _bodies:
		_bodies.erase(body)
		_release_body(body)


func _release_body(body: CharacterBody2D) -> void:
	if body and body.pushback_active:
		body.clear_pushback_force()


func _is_valid_body(body: Node) -> bool:
	return body is CharacterBody2D and body.is_in_group("Player")

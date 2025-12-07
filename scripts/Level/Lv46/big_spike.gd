extends Node2D

@export var move_speed: float = 50.0  # Tốc độ di chuyển (chậm để player có thời gian tránh)
@export var move_direction: int = -1  # -1 = trái, 1 = phải
@export var move_distance: float = 2000.0  # Khoảng cách di chuyển

var is_moving: bool = false
var start_position: Vector2
var target_position: Vector2

@onready var area: Area2D = $Area2D

func _ready() -> void:
	start_position = global_position
	# Tính toán vị trí đích dựa trên hướng di chuyển
	target_position = start_position + Vector2(move_direction * move_distance, 0)
	
	# Signal đã được kết nối trong Spike_Simple.tscn với method _on_area_2d_body_entered
	# Script này sẽ override method đó
	
	# Ẩn BigSpike ban đầu, chỉ hiện khi được kích hoạt
	visible = false
	# Disable collision ban đầu
	if area:
		area.monitoring = false

func start_moving() -> void:
	if is_moving:
		return
	
	is_moving = true
	visible = true
	if area:
		area.monitoring = true
	print("BigSpike started moving!")

func _process(delta: float) -> void:
	if not is_moving:
		return
	
	# Di chuyển ngang qua bản đồ
	var direction = (target_position - global_position).normalized()
	var distance_to_target = global_position.distance_to(target_position)
	
	if distance_to_target > 5.0:
		global_position += direction * move_speed * delta
	else:
		# Đã đến đích, dừng lại hoặc ẩn đi
		is_moving = false
		visible = false
		if area:
			area.monitoring = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Nếu player chạm vào thì die
	if body.is_in_group("Player"):
		if body.has_method("die"):
			body.die("big_spike")


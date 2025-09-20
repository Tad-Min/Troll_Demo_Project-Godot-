extends Area2D

@export var shuriken_scene: PackedScene
@export var cooldown_time: float = 2.0
@export var shuriken_speed: float = 200.0
@export var shuriken_size: float = 1.0

@export var spawner: NodePath               # 1 marker duy nhất
@export var shoot_direction: Vector2 = Vector2.LEFT   # chỉnh trong Inspector

var can_trigger: bool = true

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and can_trigger:
		var spawn_node = get_node_or_null(spawner)
		if spawn_node:
			_spawn_shuriken(spawn_node.global_position, shoot_direction)
			start_cooldown()
		else:
			push_warning("Spawner node không tồn tại, kiểm tra lại NodePath trong Inspector.")

func _spawn_shuriken(pos: Vector2, dir: Vector2) -> void:
	if shuriken_scene:
		var s = shuriken_scene.instantiate()
		get_tree().current_scene.add_child(s)
		s.global_position = pos
		# gọi setup trong shuriken.gd
		if s.has_method("setup"):
			s.setup(dir, shuriken_speed, shuriken_size)
		else:
			push_warning("⚠️ Script Shuriken chưa có hàm setup(dir, speed, size)")

func start_cooldown() -> void:
	can_trigger = false
	await get_tree().create_timer(cooldown_time).timeout
	can_trigger = true

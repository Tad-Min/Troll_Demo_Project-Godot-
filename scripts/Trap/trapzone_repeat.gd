extends Area2D

@export var shuriken_scene: PackedScene
@export var cooldown_time: float = 2.0
@export var shuriken_speed: float = 200.0
@export var shuriken_size: float = 1.0

@export var spawner: NodePath
@export var shoot_direction: Vector2 = Vector2.LEFT

var player_inside := false
var fire_timer: Timer

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

	# Create internal timer for repeated shooting
	fire_timer = Timer.new()
	fire_timer.wait_time = cooldown_time
	fire_timer.autostart = false
	fire_timer.one_shot = false
	add_child(fire_timer)
	fire_timer.connect("timeout", Callable(self, "_on_fire_timer_timeout"))


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = true
		if not fire_timer.is_stopped():
			return
		fire_timer.start()


func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		player_inside = false
		fire_timer.stop()


func _on_fire_timer_timeout() -> void:
	if not player_inside:
		fire_timer.stop()
		return

	var spawn_node = get_node_or_null(spawner)
	if spawn_node:
		_spawn_shuriken(spawn_node.global_position, shoot_direction)
	else:
		push_warning("Spawner node không tồn tại – kiểm tra NodePath")


func _spawn_shuriken(pos: Vector2, dir: Vector2) -> void:
	if shuriken_scene:
		var s = shuriken_scene.instantiate()
		get_tree().current_scene.add_child(s)
		s.global_position = pos

		if s.has_method("setup"):
			s.setup(dir, shuriken_speed, shuriken_size)
		else:
			push_warning("Shuriken script thiếu hàm setup(dir, speed, size)")

extends Area2D

@export var Trap_Door: NodePath
@export var fall_distance: float = 100.0
@export var fall_speed: float = 200.0  # tốc độ rơi px/s

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		var Door = get_node(Trap_Door)
		if Door:
			var fall_time = fall_distance / fall_speed  # thời gian tự tính theo khoảng cách

			var tween = get_tree().create_tween()
			tween.tween_property(
				Door,
				"position:y",
				Door.position.y + fall_distance,
				fall_time
			)

			queue_free()
		else:
			print("Trap node not found!")

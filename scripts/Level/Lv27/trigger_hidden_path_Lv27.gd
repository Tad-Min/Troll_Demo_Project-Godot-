extends Area2D

@export var Trap_Door: NodePath
@export var move_distance: float = 64.0 
@export var move_time: float = 0.5     

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		var Door = get_node(Trap_Door)
		if Door:
			_open_door(Door)
		else:
			print("Trap node not found!");

func _open_door(Door: Node):
	var tween = create_tween()
	tween.tween_property(
		Door,
		"position:x",
		Door.position.x + move_distance,
		move_time
	)

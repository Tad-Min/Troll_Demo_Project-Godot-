extends StaticBody2D

@export var spike1: NodePath
@export var spike2: NodePath

@export var move_distance: float
@export var speed: float
@export var loop: bool
@export var direction: Vector2

var start_position: Vector2
var moving_forward := true

func _ready() -> void:
	start_position = position
	if spike1 and spike2:
		get_node(spike1).visible = false
		get_node(spike2).visible = false
	else:
		print(name + ": Not Assign yet")
	set_process(false)

func _process(delta: float) -> void:
	if direction == Vector2.ZERO:
		return
	var move_amount = direction.normalized() * speed * delta
	if moving_forward:
		position += move_amount
		if (position - start_position).length() >= move_distance:
			if loop:
				moving_forward = false
			else:
				set_process(false)
	else:
		position -= move_amount
		if (position - start_position).length() <= 1.0:
			moving_forward = true
func start():
	get_node(spike1).visible = true
	get_node(spike2).visible = true
	set_process(true)

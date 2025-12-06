extends Area2D
@export var speed := 500
@export var max_distance := 800
var direction := 1
var start_position := Vector2.ZERO

func _ready():
	start_position = global_position
func _process(delta):
	position.x += speed * direction * delta
	if global_position.distance_to(start_position) > max_distance:
		queue_free()

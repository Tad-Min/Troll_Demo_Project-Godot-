extends "res://scripts/spear.gd"

@export var speed: float = 0.1
@export var scaleMax: Vector2

var start_scale: Vector2
func _ready() -> void:
	super._ready()
	set_process(false)

func _process(delta: float) -> void:
	var new_scale = scale

	if scaleMax.x > scale.x:
		new_scale.x = min(scale.x + speed * delta, scaleMax.x)
	elif scaleMax.x < scale.x:
		new_scale.x = max(scale.x - speed * delta, scaleMax.x)

	if scaleMax.y > scale.y:
		new_scale.y = min(scale.y + speed * delta, scaleMax.y)
	elif scaleMax.y < scale.y:
		new_scale.y = max(scale.y - speed * delta, scaleMax.y)

	scale = new_scale

	if scale == scaleMax:
		set_process(false)
		await get_tree().create_timer(0.2).timeout
		queue_free()
func start():
	set_process(true)

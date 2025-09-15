extends Node2D

@export var rotate_speed: float = 2.0
@export var rotate_time: float = 2.0
@export var sleep_time: float = 2.0

func _ready() -> void:
	visible = false
	_set_shurikens_active(false)
	set_process(false)

func _process(delta: float) -> void:
	rotate(rotate_speed * delta)

func start_rotation() -> void:
	_start_rotation()

func _start_rotation() -> void:
	visible = true
	_set_shurikens_active(true)
	set_process(true)

	await get_tree().create_timer(rotate_time).timeout
	set_process(false)
	visible = false
	_set_shurikens_active(false)
	await get_tree().create_timer(sleep_time).timeout
	_start_rotation()

func _set_shurikens_active(active: bool) -> void:
	for child in get_children():
		if child is Area2D:
			child.visible = active
			for c in child.get_children():
				if c is CollisionShape2D:
					c.disabled = not active

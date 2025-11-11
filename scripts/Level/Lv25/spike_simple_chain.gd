extends Node2D

@export var move_distance: float
@export var speed: float
@export var loop: bool
@export var direction: Vector2

@export var newScale: Vector2
@export var speedScale:= 1.0

var start_position: Vector2
var moving_forward := true
var isMove:= false
var isScale:= false

func _ready() -> void:
	start_position = position
	set_process(false)
	disable_all_areas(self)
	
func disable_all_areas(parent: Node):
	for child in parent.get_children():
		if child is Area2D:
			child.monitoring = false
		elif child.get_child_count() > 0:
			disable_all_areas(child)
	
func enable_all_areas(parent: Node):
	for child in parent.get_children():
		if child is Area2D:
			child.monitoring = true
		elif child.get_child_count() > 0:
			enable_all_areas(child)

func _process(delta: float) -> void:
	if isMove:
		Move(delta)
	if isScale:
		Scales()
	if not isMove and not isScale:
		set_process(false)

func Move(delta: float) -> void:
	if direction == Vector2.ZERO:
		return
	var move_amount = direction.normalized() * speed * delta
	if moving_forward:
		position += move_amount
		if (position - start_position).length() >= move_distance:
			if loop:
				moving_forward = false
			else:
				isMove = false
	else:
		position -= move_amount
		if (position - start_position).length() <= 1.0:
			moving_forward = true
			
func Scales() -> bool:
	var myX : float = newScale.x - scale.x
	var myY : float = newScale.y - scale.y
	
	if (myX < 0) and (myX < -speedScale):
		scale.x -= speedScale
	elif (myX > 0) and (myX > speedScale):
		scale.x += speedScale
	else:
		scale.x = newScale.x
	
	if (myY < 0) and (myY < -speedScale):
		scale.y -= speedScale
	elif (myY > 0) and (myY > speedScale):
		scale.y += speedScale
	else:
		scale.y = newScale.y
	
	if scale == newScale:
		isScale = false
		return true
	return false
	
func start():
	start_position = position
	visible = true
	enable_all_areas(self)
	set_process(true)

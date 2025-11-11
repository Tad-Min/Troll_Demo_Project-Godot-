extends "res://scripts/Trap/spike_simple.gd"

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
	set_process(true)

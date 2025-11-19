extends Node2D

@export var Movespeed: float
@export var newPosition: Vector2

@export var newScale: Vector2
@export var speedScale:= 1.0

var start_position: Vector2
var moving_forward := true
var isMove:= false
var isScale:= false

func _ready() -> void:
	set_process(false)

func _process(_delta: float) -> void:
	if isMove:
		Move()
	if isScale:
		Scales()
	if not isMove and not isScale:
		set_process(false)

func Move() -> bool:
	var myLX : float = newPosition.x - position.x
	var myLY : float = newPosition.y - position.y
	
	if (myLX < 0) and (myLX < -speedScale):
		position.x -= Movespeed
	elif (myLX > 0) and (myLX > speedScale):
		position.x += Movespeed
	else:
		position.x = newPosition.x
	
	if (myLY < 0) and (myLY < -speedScale):
		position.y -= Movespeed
	elif (myLY > 0) and (myLY > speedScale):
		position.y += Movespeed
	else:
		position.y = newPosition.y
	
	if position == newPosition:
		isMove = false
		return true
	return false
	
	
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
	set_process(true)

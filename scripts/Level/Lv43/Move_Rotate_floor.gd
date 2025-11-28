extends Node2D

@export var speedMove: float
@export var moveLoop:= false
@export var newPosition: Vector2

@export var speedScale:= 1.0
@export var newScale: Vector2


@export var speedRotate: float = 0.1
@export var rotateLetToRight := true
@export var newRotation:= self.rotation_degrees

var oldPosition: Vector2
var moving_forward := true
var isMove:= false
var isScale:= false
var isRotate:= false

func _ready() -> void:
	oldPosition = self.position
	set_process(false)

func _process(_delta: float) -> void:
	
	if isMove:
		if Move():
			if moveLoop:
				var temp = newPosition
				newPosition = oldPosition
				oldPosition = temp
				isMove = true 
	if isScale:
		Scales()
	if isRotate:
		Rotate()
	
	if not isMove and not isScale and not isRotate:
		set_process(false)

func Rotate() -> bool:
	var diff := newRotation - rotation_degrees
	var step := speedRotate
	if not rotateLetToRight:
		step = -speedRotate
	if abs(diff) <= abs(step):
		rotation_degrees = newRotation
		isRotate = false
		return true
	rotation_degrees += step
	return false
	
func Move() -> bool:
	var myLX : float = newPosition.x - position.x
	var myLY : float = newPosition.y - position.y
	
	if (myLX < 0) and (myLX < -speedScale):
		position.x -= speedMove
	elif (myLX > 0) and (myLX > speedScale):
		position.x += speedMove
	else:
		position.x = newPosition.x
	
	if (myLY < 0) and (myLY < -speedScale):
		position.y -= speedMove
	elif (myLY > 0) and (myLY > speedScale):
		position.y += speedMove
	else:
		position.y = newPosition.y
		
	if position.y == newPosition.y and position.x == newPosition.x:
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
		isScale = false
		return true
	
	if (myY < 0) and (myY < -speedScale):
		scale.y -= speedScale
	elif (myY > 0) and (myY > speedScale):
		scale.y += speedScale
	else:
		scale.y = newScale.y
		isScale = false
		return true
		
	return false
	
func start():
	set_process(true)

extends Node2D
@export var speed : float
@export var boss_scale : Vector2
@export var animations: Array[String] = ["idle", "summon", "attack","skill1"]	
@onready var player: Node2D = get_node("../Player")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var animation_duration: float

var timer: Timer
var current_animation_index: int = 0

func _ready():
	scale = boss_scale
	sprite.play(animations[current_animation_index])
	timer = Timer.new()
	timer.wait_time = animation_duration
	timer.autostart = true
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)

func _on_timer_timeout():
	current_animation_index = (current_animation_index + 1) % animations.size()
	sprite.play(animations[current_animation_index])


   
	

func _process(delta):
	# Di chuyển boss về phía player
	position += Vector2.RIGHT * speed * delta

 
 

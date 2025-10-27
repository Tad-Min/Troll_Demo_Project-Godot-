extends Node2D

@export var speed: float = 100.0
@export var boss_scale: Vector2
@export var animations: Array[String] = ["idle", "summon", "attack", "skill1"]
@export var animation_duration: float = 2.0


@onready var player: Node2D = get_node("../Player")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


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

	# Nếu animation là skill1 thì bắn shuriken
	

func _process(delta):
	# Boss di chuyển về phía player
	if player:
		var dir = (player.global_position - global_position).normalized()
		position += dir * speed * delta




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):  
		if body.has_method("die"):  # make sure the player has die() function
			body.die()

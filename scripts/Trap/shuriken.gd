extends Area2D

@export var velocity: Vector2 = Vector2.ZERO
@export var speed: float = 200.0
@onready var anim = $AnimatedSprite2D
@onready var sfx  = $AudioStreamPlayer

func _ready():
	anim.play("spin")  

func _process(delta):
	position += velocity * speed * delta
func setup(direction: Vector2, spd: float, size_scale: float = 1.0) -> void:
	velocity = direction.normalized()
	speed = spd
	rotation = velocity.angle()
	scale = Vector2.ONE * size_scale
	if sfx:
		sfx.play()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):  
		if body.has_method("die"):  # make sure the player has die() function
			body.die("trap")

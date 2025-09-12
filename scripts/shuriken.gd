extends Area2D

@export var velocity: Vector2 = Vector2.ZERO
@export var speed: float = 200.0
@onready var anim = $AnimatedSprite2D
@onready var sfx  = $AudioStreamPlayer

func _ready():
	anim.play("spin")  
	sfx.play()

func _process(delta):
	position += velocity * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):  
		if body.has_method("die"):  # make sure the player has die() function
			body.die()

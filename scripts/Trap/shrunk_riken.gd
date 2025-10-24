extends Area2D

@export var velocity: Vector2 = Vector2.ZERO
@export var speed: float = 200.0
@export var min_scale: float = 0.2
@export var disappear_on_min: bool = true

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx: AudioStreamPlayer = $AudioStreamPlayer

var shrinking: bool = false
var shrink_timer: float = 0.0
var shrink_duration: float = 1.5
var base_scale: Vector2

func _ready() -> void:
	anim.play("spin")

func _process(delta: float) -> void:
	# Move the projectile
	position += velocity * speed * delta

	# Handle shrinking animation
	if shrinking:
		shrink_timer += delta
		var t : float = clamp(shrink_timer / shrink_duration, 0.0, 1.0)
		scale = base_scale.lerp(Vector2(min_scale, min_scale), t)

		if t >= 1.0:
			shrinking = false
			if disappear_on_min:
				queue_free()

func setup(direction: Vector2, spd: float, shrink_dur: float, max_scale: float = 1.0, min_scale_value: float = 0.0) -> void:
	velocity = direction.normalized()
	speed = spd
	rotation = velocity.angle()
	scale = Vector2.ONE * max_scale
	base_scale = scale
	shrink_duration = shrink_dur
	min_scale = min_scale_value
	start_shrink()
	if sfx:
		sfx.play()

func start_shrink() -> void:
	shrinking = true
	shrink_timer = 0.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("die"):
			body.die("trap")

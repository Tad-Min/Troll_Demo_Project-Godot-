extends Area2D
@export var speed := 500
@export var max_distance := 10000
var direction := 1
var start_position := Vector2.ZERO
var has_hit := false
@onready var sprite: Sprite2D = $Arrow

func _ready():
	start_position = global_position
	# Connect to area_entered to detect boss Area2D
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)
	_update_facing()

func _process(delta):
	# Ensure sprite faces current direction even if direction set after _ready
	_update_facing()
	position.x += speed * direction * delta
	if global_position.distance_to(start_position) > max_distance:
		queue_free()

func _on_body_entered(body: Node) -> void:
	# This handles CharacterBody2D collisions
	pass

func _on_area_entered(area: Area2D) -> void:
	# Check if we hit the boss's Area2D
	if has_hit:
		return
	
	var parent = area.get_parent()
	if parent and parent.name == "CharacterBody2D":
		var boss_node = parent.get_parent()
		if boss_node and boss_node.name == "FinalBoss":
			has_hit = true
			# The boss will handle damage in its own script
		queue_free()

func _update_facing() -> void:
	if sprite:
		sprite.flip_h = direction < 0

extends Node2D
@export var animate_state : Array[String] = ["idle","attack","skill","summon"]

signal boss_died
signal hp_changed(current_hp: int, max_hp: int)

@export var max_hp: int = 50
var current_hp: int = 50

func _ready() -> void:
	current_hp = max_hp
	emit_signal("hp_changed", current_hp, max_hp)
	# Connect to Area2D for arrow detection
	var area = $CharacterBody2D/Area2D
	if area:
		area.area_entered.connect(_on_area_entered)

func take_damage(amount: int = 1) -> void:
	current_hp -= amount
	print("Boss took damage! HP: ", current_hp, "/", max_hp)
	emit_signal("hp_changed", current_hp, max_hp)
	
	if current_hp <= 0:
		current_hp = 0
		emit_signal("hp_changed", current_hp, max_hp)
		die()

func die() -> void:
	print("Boss defeated!")
	emit_signal("boss_died")
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	# Check if the area is an arrow
	var area_name = area.name
	if area_name == "Arrow" or "Arrow" in area_name:
		take_damage(1)
		# Remove the arrow
		if is_instance_valid(area):
			area.queue_free()

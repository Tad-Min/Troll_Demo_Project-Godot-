extends Node2D

@onready var box = $Box
@onready var fire = $Fire


var fire_frames = [0, 1, 2, 3]

func _ready():
	box.play("Box")  
	fire.play("fire")



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):  
		if body.has_method("die"):  # make sure the player has die() function
			body.die()

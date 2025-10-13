extends Node2D


func _ready():
	$AnimatedSprite2D.play("Spear")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):  
		if body.has_method("die"):  # make sure the player has die() function
			body.die("trap")
			
 

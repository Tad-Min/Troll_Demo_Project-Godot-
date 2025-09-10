extends Node2D

func _ready():
	$AnimatedSprite2D.play("Spike")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":   
		print("Player dính bẫy!")  
		if body.has_method("take_damage"):
			body.take_damage(1)   

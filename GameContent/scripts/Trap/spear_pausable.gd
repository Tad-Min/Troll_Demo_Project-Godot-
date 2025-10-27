extends Node2D

@export var pause_frame: int = 0      
@export var pause_duration: float = 1.0 

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var paused: bool = false

func _ready():
	anim.play("Spear")
	anim.frame_changed.connect(_on_frame_changed)
	
func _on_frame_changed():
	if anim.frame == pause_frame and not paused:
		paused = true
		anim.pause()
		await get_tree().create_timer(pause_duration).timeout
		anim.play()
		paused = false  # ✅ reset so it can pause again next loop

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not paused:  
		if body.has_method("die"):
			body.die("trap")

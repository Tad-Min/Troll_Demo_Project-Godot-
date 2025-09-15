extends Node2D



#func _ready() -> void:
	#visible = false
	#set_physics_process(false)
func _process(delta: float) -> void:
	rotate(0.1)

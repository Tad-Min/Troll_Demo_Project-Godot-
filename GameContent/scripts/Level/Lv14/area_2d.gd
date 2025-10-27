extends Area2D

@export var spike: Node2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func  _body_entered(body:Node2D) -> void:
	if body.is_in_group("Player"):
		spike.get_node("RigidBody2D").gravity_scale = 1

extends Node2D

@export var Lock: NodePath
var isActive := false

func _ready() -> void:
	if Lock: 
		$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print("Not Assign Lock yet")
func _on_body_entered(body: Node) -> void:
	if Lock and  body.is_in_group("Player") and not isActive:
		var lock = get_node(Lock)
		$AnimatedSprite2D.play("default")
		isActive = true
		lock.queue_free()

extends Node2D

@export var increase_amount: float = 1.5
@export var light_path: NodePath  
@export var Lock: NodePath
var isActive := false

func _ready() -> void:
	if Lock and light_path: 
		$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	else:
		print(name + " Not Assign Lock and Light path yet")
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and not isActive:
		var light = body.get_node_or_null(light_path)
		if light and light is PointLight2D:
			light.texture_scale += increase_amount
		var lock = get_node(Lock)
		$AnimatedSprite2D.play("default")
		isActive = true
		lock.queue_free()

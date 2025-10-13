extends Area2D

@export var False_Spike: NodePath

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		var Spike = get_node(False_Spike)
		if Spike:
			Spike.queue_free()
			queue_free()
		else:
			print("Spike not found!");

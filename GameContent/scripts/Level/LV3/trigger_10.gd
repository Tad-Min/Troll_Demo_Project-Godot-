extends Area2D

@export var Spike_5: NodePath
@export var Floor_trap: NodePath

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		if Spike_5 and Floor_trap:
			var spike = get_node(Spike_5)
			var trap = get_node(Floor_trap)
			if spike and trap:
				spike.start()
				trap.start()
				queue_free()
			else:
				print("Trap node not found!");

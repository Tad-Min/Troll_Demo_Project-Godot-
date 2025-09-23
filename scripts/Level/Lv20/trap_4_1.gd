extends Area2D

@export var floortrap4:Node

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$SpikeSimple4_1.visible = true
		$SpikeSimple4_1/Area2D.monitoring = true
		floortrap4.queue_free()
		monitoring = false

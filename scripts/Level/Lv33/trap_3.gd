extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		var spike_simple = get_node_or_null("SpikeSimple42")
		if spike_simple:
			spike_simple.isScale = true
			spike_simple.start()

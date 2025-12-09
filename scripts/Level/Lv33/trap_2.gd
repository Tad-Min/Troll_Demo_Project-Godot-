extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		var spike_simple = get_node_or_null("../SpikeSimple")
		if spike_simple:
			spike_simple.visible = true
			var spike_area = spike_simple.get_node_or_null("Area2D")
			if spike_area:
				spike_area.monitoring = true

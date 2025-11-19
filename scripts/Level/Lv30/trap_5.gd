extends Area2D

func _ready() -> void:
	$"../SpikeSimple4/Area2D".monitoring = false
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		$"../SpikeSimple4/Area2D".monitoring = true
		$"../SpikeSimple4".visible = true

extends Area2D

func _ready() -> void:
	$SpikeSimple3/Area2D.monitoring = false
	$SpikeSimple3.visible = false
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		$SpikeSimple3.visible = true
		$SpikeSimple3/Area2D.monitoring = true
		$"../Trap5".monitoring = true

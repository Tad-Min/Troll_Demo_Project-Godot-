extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$SpikeSimple6_1.visible = true
		$SpikeSimple6_1/Area2D.monitoring = true
		$SpikeSimple6_2.visible = true
		$SpikeSimple6_2/Area2D.monitoring = true
		$SpikeSimple6_1.start()
		$SpikeSimple6_2.start()
		set_deferred("monitoring", false)

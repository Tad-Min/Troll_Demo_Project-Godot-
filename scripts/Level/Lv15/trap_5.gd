extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$SpikeSimple5.visible = true
		$SpikeSimple5/Area2D.monitoring = true
		$SpikeSimple5.start()
		set_deferred("monitoring", false)

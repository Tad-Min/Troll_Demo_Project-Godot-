extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$SpikeSimple10.visible = true
		$SpikeSimple10/Area2D.monitoring = true
		set_deferred("monitoring", false)

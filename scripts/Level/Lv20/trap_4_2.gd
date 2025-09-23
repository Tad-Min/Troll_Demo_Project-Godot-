extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$Spike4_2.visible = true
		$Spike4_2/Area2D.monitoring = true
		monitoring = false

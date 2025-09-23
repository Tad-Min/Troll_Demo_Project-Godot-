extends Area2D

func _ready() -> void:
	$SpikeSimple1_0.visible = false
	$SpikeSimple1_1.visible = false
	connect("body_entered",Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$SpikeSimple1_0.visible = true
		$SpikeSimple1_1.visible = true
		monitoring = false

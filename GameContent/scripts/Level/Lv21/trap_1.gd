extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$"../Rotate_Simple_Spike/SpikeSimple1".start()
		$"../Rotate_Simple_Spike/SpikeSimple5".start()
		call_deferred("set_monitoring", false)

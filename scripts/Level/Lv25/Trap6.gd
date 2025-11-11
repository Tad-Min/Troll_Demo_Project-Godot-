extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		$"../../SpikeSimple 3".isScale = true
		$"../../SpikeSimple 3".start()
		
		while $"../../SpikeSimple 3".isScale:
			await get_tree().create_timer(0.1).timeout
		

extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		
		$"../../SpikeSimple chain".isMove = true
		$"../../SpikeSimple chain".start()
		
		while $"../../SpikeSimple chain".isMove:
			await get_tree().create_timer(0.1).timeout
			
		$"../../SpikeSimple chain".direction = Vector2(-1,-1)
		
		

extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		$"../../SpikeSimple chain".isMove = true
		$"../../SpikeSimple 3".isMove = true
		$"../../SpikeSimple chain".start()
		$"../../SpikeSimple 3".start()
		
		while $"../../SpikeSimple 3".isMove:
			await get_tree().create_timer(0.1).timeout
		$"../../SpikeSimple 3".direction = Vector2(0,1)
		$"../../SpikeSimple 3".move_distance = 88
		$"../../SpikeSimple 3".speed = 500
		

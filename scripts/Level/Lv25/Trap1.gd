extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		
		$"../../SpikeSimple 1".isMove = true
		$"../../SpikeSimple 1".isScale = true
		$"../../SpikeSimple 1".start()
		
		while $"../../SpikeSimple 1".isScale or $"../../SpikeSimple 1".isMove:
			await get_tree().create_timer(0.1).timeout
		
		$"../../SpikeSimple 1".move_distance = 824
		$"../../SpikeSimple 1".speed = 300
		$"../../SpikeSimple 1".direction = Vector2(1,0)
		
		

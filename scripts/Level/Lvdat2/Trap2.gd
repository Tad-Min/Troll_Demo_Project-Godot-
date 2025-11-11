extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		while $"../../SpikeSimple 2".isScale or $"../../SpikeSimple 2".isMove:
			await get_tree().create_timer(0.1).timeout
		
		$"../../SpikeSimple 2".isMove = true
		$"../../SpikeSimple 2".start()
		
		while $"../../SpikeSimple 2".isScale or $"../../SpikeSimple 2".isMove:
			await get_tree().create_timer(0.1).timeout
		
		$"../../SpikeSimple 2".move_distance = 824
		$"../../SpikeSimple 2".speed = 300
		$"../../SpikeSimple 2".direction = Vector2(1,0)

extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		$"../../SpikeSimple 3".isMove = true
		$"../../SpikeSimple 3".start()
		
		while $"../../SpikeSimple 3".isMove:
			await get_tree().create_timer(0.1).timeout
			
		$"../../SpikeSimple 3".direction = Vector2(1,0)
		$"../../SpikeSimple 3".move_distance = 1000
		$"../../SpikeSimple 3".speed = 80
		
		$"../../SpikeSimple 3".isMove = true
		$"../../SpikeSimple 3".start()

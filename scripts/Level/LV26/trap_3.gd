extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		
		$"../SpikeSimple2".isMove = true
		$"../SpikeSimple2".start()
		
		while $"../SpikeSimple1".isMove:
			if get_tree():
				await get_tree().create_timer(0.1).timeout
			
		$"../SpikeSimple1".isMove = true
		$"../SpikeSimple1".start()
		
		while $"../SpikeSimple1".isMove:
			if get_tree():
				await get_tree().create_timer(0.1).timeout

		$"../SpikeSimple1".newPosition = Vector2(890.0, 562.0)
		$"../SpikeSimple1".Movespeed = 3
		$"../SpikeSimple1".isMove = true
		$"../SpikeSimple1".start()

extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		$"../Jumper".visible = true
		$"../Jumper/Area2D".monitoring = true
		$"../SpikeSimple1".isScale = true
		$"../SpikeSimple1".isMove = true
		$"../SpikeSimple1".start()
		
		while $"../SpikeSimple1".isMove or $"../SpikeSimple1".isScale:
			if get_tree():
				await get_tree().create_timer(0.1).timeout

		$"../SpikeSimple1".newPosition = Vector2(112.0, 312.0)
		$"../SpikeSimple1".Movespeed = 2
		$"../SpikeSimple1".isMove = true
		$"../SpikeSimple1".start()
		
		while $"../SpikeSimple1".isMove or $"../SpikeSimple1".isScale:
			if get_tree():
				await get_tree().create_timer(0.1).timeout
			
		$"../SpikeSimple1".newPosition = Vector2(112.0, 562.0)

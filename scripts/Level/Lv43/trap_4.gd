extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		call_deferred("set_monitoring", false)
		$SpikeSimple.isMove = true
		$SpikeSimple.start()
		
		while $SpikeSimple.isMove:
			if get_tree():
				await get_tree().create_timer(0.1).timeout
		
		$SpikeSimple.newPosition = Vector2(56,200)
		$SpikeSimple.isMove = true
		$SpikeSimple.start()

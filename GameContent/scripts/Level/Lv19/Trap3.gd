extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		set_deferred("monitoring", false)
		$Fly.start()
		$"../../Pad/Floor".visible = true
		$"../../CbTrap4".start()
		

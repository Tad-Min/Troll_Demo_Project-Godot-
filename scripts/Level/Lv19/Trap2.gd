extends Area2D

func _ready() -> void:
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$Spike.visible = true
		$SpikeSimple.visible = true
		$FLy.visible = true
		$"../../CbTrap3".start()
		set_deferred("monitoring", false)

extends Area2D

func _ready() -> void:
	$Jumper.visible = false
	$Jumper/Area2D.monitoring = false
	$Spike.visible = false
	$Spike/Area2D.monitoring = false
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		$Jumper.visible = true
		$Jumper/Area2D.monitoring = true
		$Spike.visible = true
		$Spike/Area2D.monitoring = true
		$Move.isMove = true
		$Move.start()

extends Area2D

func _ready() -> void:
	$Spear.visible = false
	connect("body_entered", Callable(self, "_body_entered"))
	
func _body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		set_deferred("monitoring", false)
		$Spear.visible = true

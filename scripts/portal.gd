extends Node2D

signal player_entered  # custom signal for the game center

func _ready() -> void:
	# connect the Area2D's built-in signal to our handler
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	print("portal ready")

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):  # only trigger for the player
		print("Player entered the portal!")
		emit_signal("player_entered")  # notify GameCenter

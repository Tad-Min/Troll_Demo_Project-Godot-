extends Area2D

@export var Center: Node2D
@export var rotation_amount: float = 10.0
@export var rotation_duration: float = 0.5  # seconds

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		var tween = create_tween()
		tween.tween_property(Center, "rotation_degrees",
			Center.rotation_degrees + rotation_amount,
			rotation_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

		# Optional: destroy this Area2D after animation completes
		tween.tween_callback(Callable(self, "queue_free"))

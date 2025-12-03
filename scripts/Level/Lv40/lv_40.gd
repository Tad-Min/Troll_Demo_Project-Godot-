extends Node2D

func _ready() -> void:
	$SpikeSimple.visible = false
	$SpikeSimple/Area2D.monitoring = false
	$SpikeSimple2.visible = false
	$SpikeSimple2/Area2D.monitoring = false

func _on_button_1_button_activated() -> void:
	$Floor1.isMove = true
	$Floor1.start()
	$Floorportal.newPosition = $Floorportal.position + Vector2(0,-90.6)
	$Floorportal.isMove = true
	$Floorportal.start()

func _on_button_2_button_activated() -> void:
	$Floor2.isMove = true
	$Floor2.start()

func _on_button_4_button_activated() -> void:
	$Floor3.isMove = true
	$Floor3.start()
	$Floorportal.newPosition = $Floorportal.position + Vector2(0,-90.6)
	$Floorportal.isMove = true
	$Floorportal.start()

func _on_button_5_button_activated() -> void:
	$Floor4.isMove = true
	$Floor4.start()
	$SpikeSimple.visible = true
	$SpikeSimple/Area2D.monitoring = true
	$Floorportal.newPosition = $Floorportal.position + Vector2(0,-90.6)
	$Floorportal.isMove = true
	$Floorportal.start()
	
func _on_trap_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$SpikeSimple2.visible = true
		$SpikeSimple2/Area2D.monitoring = true
		

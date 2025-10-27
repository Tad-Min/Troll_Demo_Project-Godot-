extends Area2D

@export var Map: Node2D
@export var move_distance: Vector2 = Vector2(500, 0)  # how far to teleport each trigger
@export var camera : Camera2D
@export var cam_vector: Vector2

@export var player_message: RichTextLabel
@export var pause: Control

@export var messages: Array[String] = []

var counter = 0
var msg_counter = 0

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player") and Map and not camera.zoom <= cam_vector:
		Map.position += move_distance
		counter += 1
		
	if counter == 40:
		_show_text()
		counter = 0
		
func _show_text() -> void:
	if player_message==null or pause== null:
		return
	if msg_counter<messages.size():
		if messages.get(msg_counter) == "":
			pause.open_pause_menu() 
		else:
			player_message.text = messages.get(msg_counter)

	msg_counter+=1
	
	var timer := get_tree().create_timer(5)
	timer.timeout.connect(func():
		player_message.text = ""
	)

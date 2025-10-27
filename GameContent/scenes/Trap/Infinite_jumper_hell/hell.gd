extends Area2D

@export var player_message: RichTextLabel
@export var pause: Control
@export var portal_scene: PackedScene = preload("res://scenes/portal.tscn")
@export var spike_scene: PackedScene = preload("res://scenes/Trap/spike.tscn")
@export var player : Node2D

var timer = 0

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node):
	if body.is_in_group("Player"):
		print("player is trapped")
		print(timer)
		timer +=1

		
	if timer == 3:
		print("Pro tips: restart this level in menu.")
		player_message.text = "Pro tips: restart level in menu."

		
	if timer == 10:
		player_message.text= "Let me open the menu for you."
	if timer == 20:
		print("opening menu")
		if pause!=null:
			pause.open_pause_menu() 

		
	if timer == 22:
		player_message.text = "why are you still here?"
		
	if timer == 35:
		player_message.text = "U good?"
		
		
	if timer == 50:
		player_message.text = "Seeing things yet?"
	
	if timer > 53:
		_spawn_portal(player)
		
	if timer == 55:
		player_message.text = "That portal looks a bit too real right?"
		
	if timer == 70:
		player_message.text = "Just saying...you are starting to hallucinate..."
		
	if timer == 90:
		player_message.text ="Okay let me give you a favor."
		
	if timer == 110:
		player_message.text ="Nahhh just kidding."
		
	if timer >120:
		_spawn_spike(player)
		
	

func _spawn_portal(player: Node2D):
	if portal_scene:
		var portal_instance = portal_scene.instantiate()
		get_tree().current_scene.add_child(portal_instance)

		var min_dist = 100.0   # minimum distance away from player
		var max_dist = 200.0  # maximum distance away from player

		# pick random angle and distance
		var angle = randf_range(0, TAU)  # TAU = 2 * PI
		var dist = randf_range(min_dist, max_dist)

		# convert polar to cartesian
		var offset = Vector2(cos(angle), sin(angle)) * dist
		portal_instance.scale = Vector2(0.7, 0.7)
		portal_instance.global_position = player.global_position + offset

func _spawn_spike(player: Node2D):
	if spike_scene:
		var spike_instance = spike_scene.instantiate()
		spike_instance.global_position = player.global_position
		

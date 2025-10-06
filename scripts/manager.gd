extends Node

@export var Portal: NodePath = "../Portal"
@export var current_level: int

func _ready() -> void:
	print("Manager ready!")
	print("current level: %d",current_level)
	GameData.current_level = current_level - 1;
	GameData.reset_gems(3)

	# connect to portal
	var portal = get_node_or_null(Portal)
	if portal:
		portal.connect("player_entered", Callable(self, "on_portal_entered"))
	else:
		push_error("Portal not found! Check your node path or name.")

	# connect to player
	var player = get_node_or_null("../Player")
	if player:
		player.connect("died", Callable(self, "on_player_died"))
	else:
		push_error("Player not found! Check your node path or name.")


func on_portal_entered() -> void:
	print("Manager: Portal entered, level completed...")
	_go_to_next_screen()

func _go_to_next_screen() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/Next.tscn")  # chỉ chuyển đến màn Next


func on_player_died(cause: String = "") -> void:
	if cause != "":
		GameData.last_death_cause = cause
	print("Manager: Player died (", GameData.last_death_cause, ") → going to game over...")
	_go_to_game_over()

func _go_to_game_over() -> void:
	print("Manager: game is over!")
	await get_tree().create_timer(1.0).timeout
	

	var current_scene = get_tree().current_scene
	if current_scene:
		get_tree().set_meta("last_level", current_scene.scene_file_path)
		print(get_tree().get_meta("last_level", current_scene.scene_file_path))
		
	GameData.Levels[GameData.current_level].countDie +=1
	print(GameData.Levels[GameData.current_level].countDie)
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")

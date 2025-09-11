extends Node

func _ready() -> void:
	print("Manager ready!")

	# Xác định level hiện tại
	_set_current_level_index()

	# connect to portal
	var portal = get_node_or_null("../Portal")
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


func _set_current_level_index() -> void:
	var current_path = get_tree().current_scene.scene_file_path
	for i in GameData.level_paths.size():
		if GameData.level_paths[i] == current_path:
			GameData.current_level_index = i
			print("Current level index: ", i)
			break


func on_portal_entered() -> void:
	print("Manager: Portal entered, level completed...")
	_go_to_next_screen()

func _go_to_next_screen() -> void:
	await get_tree().create_timer(1.0).timeout

	var current_index = GameData.current_level_index
	var next_index = current_index + 1
	if next_index < GameData.level_paths.size():
		GameData.next_level_path = GameData.level_paths[next_index]
		GameData.current_level_index = next_index  # ← cập nhật luôn index

	get_tree().change_scene_to_file("res://scenes/Next.tscn")  # chỉ chuyển đến màn Next


func on_player_died() -> void:
	print("Manager: Player died → going to game over...")
	GameData.death_count += 1  # Tăng số lần chết
	_go_to_game_over()

func _go_to_game_over() -> void:
	print("Manager: game is over!")
	await get_tree().create_timer(1.0).timeout
	

	var current_scene = get_tree().current_scene
	if current_scene:
		get_tree().set_meta("last_level", current_scene.scene_file_path)
		print(get_tree().get_meta("last_level", current_scene.scene_file_path))

	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")

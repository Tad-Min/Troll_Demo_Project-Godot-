extends Node

@export var Portal: NodePath = "../Portal"
@export var current_level: int

func _ready() -> void:
	print("Portal manager ready!")
	print("current level: %d" %current_level)
	GameData.reset_pending_keys()
	
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
	GameData.commit_pending_keys()
	_go_to_next_screen()

func _go_to_next_screen() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/GameSceneUI/Next.tscn")  # chỉ chuyển đến màn Next

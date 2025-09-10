extends Node

func _ready() -> void:
	print("Manager ready!")
	
	# safer way: find by absolute path or by group
	var portal = get_node_or_null("../Portal")
	if portal:
		portal.connect("player_entered", Callable(self, "on_portal_entered"))
	else:
		push_error("Portal not found! Check your node path or name.")
	
	var player = get_node_or_null("../Player")
	if player:
		player.connect("player_died", Callable(self, "on_death"))
	else:
		push_error("PLayer not found! Check your node path or name.")
			
	

func on_portal_entered() -> void:
	print("Manager: Portal entered, level completed...")
	
func on_death() -> void:
	print("Manager: player died. try again")

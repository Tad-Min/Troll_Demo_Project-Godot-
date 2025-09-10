extends Node

func _ready() -> void:
	print("Manager ready!")
	
	# safer way: find by absolute path or by group
	var portal = get_node_or_null("../Portal")
	if portal:
		portal.connect("player_entered", Callable(self, "on_portal_entered"))
	else:
		push_error("Portal not found! Check your node path or name.")

func on_portal_entered() -> void:
	print("Manager: Portal entered, level completed...")

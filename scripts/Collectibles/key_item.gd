extends Area2D

## Script for collectible key items
## When player touches the key, it adds to GameData.keys_collected and removes itself

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	# Ensure monitoring is enabled
	monitoring = true

func _on_body_entered(body: Node) -> void:
	# Check if body is CharacterBody2D or RigidBody2D (Player types)
	if body and (body.is_in_group("Player") or body.name == "Player" or "Player" in body.name):
		GameData.collect_key()
		# Remove the entire key node (parent of Area2D)
		get_parent().queue_free()

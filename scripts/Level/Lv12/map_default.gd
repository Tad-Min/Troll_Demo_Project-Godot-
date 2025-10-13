extends TileMapLayer
@export var default: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		collision_enabled = default
		visible = default

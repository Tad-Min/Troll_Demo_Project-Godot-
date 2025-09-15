extends ProgressBar 

var player

func _ready() -> void:
	# Assuming this bar is a direct child of Player
	player = get_parent()
	min_value = 0
	max_value = 100


func _process(delta: float) -> void:
	if player:
		# Map jump_charge (0.75 - 1.75) to percentage
		var percent = (player.jump_charge - player.min_jc) / (player.max_jc - player.min_jc) * 100.0
		value = clamp(percent, 0, 100)
	if value == 0:
		show_percentage = false
	else:
		show_percentage = true

extends TextureRect

@onready var bgs: Array = [$Bg_layer1,$Bg_layer2, $Bg_layer3, $Bg_layer4, $Bg_layer5];

@export var amplitude := 10.0
@export var speed := 1.0

var base_positions: Array = []

func _ready() -> void:
	for bg in bgs:
		base_positions.append(bg.position)

func _process(delta: float) -> void:
	var t = Time.get_ticks_msec() / 1000.0 * speed
	for i in bgs.size():
		var bg = bgs[i]
		var base_pos = base_positions[i]
		bg.position.x = base_pos.x + sin(t + i) * amplitude

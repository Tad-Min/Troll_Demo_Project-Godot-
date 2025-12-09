extends RichTextLabel
@export var text_speed: float = 0.03

@export var can_skip: bool = true
@export var skip_key: Key = KEY_SPACE

# Bật hiệu ứng RGB
@export var rgb_effect: bool = true

@export var rgb_speed: float = 1.0

var full_text: String = ""
var current_index: int = 0
var is_typing: bool = false
var is_finished: bool = false
var rgb_time: float = 0.0

func _ready():
	if not rgb_effect:
		add_theme_color_override("default_color", Color.BLACK)
	
	full_text = """Thanks for grinding all the way to the end—
surviving every bug, every rage moment, every “I’m gonna uninstall” crisis…and still coming back for more.
You’re basically the definition of: “I don’t quit. I just quit sleeping.”
Congrats on beating the game! Now go rest, pro.
The game is over, but your real-life deadlines are still camping outside. 💀"""
	
	text = ""  
	start_typing()

func _process(delta):
	if rgb_effect:
		rgb_time += delta * rgb_speed
		var hue = fmod(rgb_time, 1.0)  
		var rgb_color = Color.from_hsv(hue, 1.0, 1.0)  
		add_theme_color_override("default_color", rgb_color)

func start_typing():
	is_typing = true
	is_finished = false
	type_next_character()

func type_next_character():
	if current_index < full_text.length() and is_typing:
		text += full_text[current_index]
		current_index += 1
		await get_tree().create_timer(text_speed).timeout
		type_next_character()
	else:
		is_typing = false
		is_finished = true

func skip_to_end():
	"""Hiển thị toàn bộ text ngay lập tức"""
	text = full_text
	current_index = full_text.length()
	is_typing = false
	is_finished = true

func _input(event):
	if can_skip and event is InputEventKey:
		if event.pressed and event.keycode == skip_key:
			if is_typing:
				skip_to_end()
func restart_typing():
	current_index = 0
	text = ""
	start_typing()

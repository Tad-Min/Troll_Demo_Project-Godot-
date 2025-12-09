extends RichTextLabel
@export var text_speed: float = 0.05
@export var can_skip: bool = true
@export var skip_key: Key = KEY_SPACE

var first_text: String = """Still here? Damn, respect.
Thanks for surviving this far—desk-slams, rage quits, maybe even uninstalling included.
Only one thing left: The Final Boss.
He's been ruling this forest for 100+ years, strong and evil as hell.
Wanna face him? Get all 3 Keys first.Not enough? Turn back.
Got them? Congrats—final gate unlocked. Gear up, pro.
It's showtime!!!!."""

var second_text: String = """
Hints for you if you can't find enough keys:
	
" Three numbers guard three keys.
Between the first and the second lies 16,
between the second and the last lies 15.
Their total is 68 "."""

var full_text: String = ""
var current_index: int = 0
var is_typing: bool = false
var is_finished: bool = false
var is_first_part: bool = true

func _ready():
	full_text = first_text
	text = ""  
	start_typing()

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
	text = full_text
	current_index = full_text.length()
	is_typing = false
	is_finished = true

func show_second_part():
	"""Hiển thị phần text thứ 2"""
	is_first_part = false
	text = ""  # Xóa text cũ
	full_text = second_text  # Chỉ hiển thị text mới
	current_index = 0  # Bắt đầu từ đầu
	start_typing()

func _input(event):
	if can_skip and event is InputEventKey:
		if event.pressed and event.keycode == skip_key:
			if is_typing:
				# Đang gõ -> Skip
				skip_to_end()
			elif is_finished and is_first_part:
				# Text 1 xong -> Hiện text 2
				show_second_part()

func restart_typing():
	current_index = 0
	text = ""
	is_first_part = true
	full_text = first_text
	start_typing()

extends Node2D

@onready var final_boss: Node2D = $FinalBoss
@onready var victory_to_open: StaticBody2D = $Victory_to_open
@onready var boss_hp_bar: ProgressBar = $BossHPUI/BossHPBar
@onready var boss_hp_label: Label = $BossHPUI/BossHPLabel
@onready var big_spike: Node2D = $BigSpike
@onready var spike_balls: Array = [
	$SpikeBall1,
	$SpikeBall2,
	$SpikeBall3,
	$SpikeBall4,
]

var big_spike_activated: bool = false
var big_spike_reverse_triggered: bool = false
var spike_balls_triggered: bool = false

func _ready() -> void:
	# Connect boss_died signal
	if final_boss:
		final_boss.boss_died.connect(_on_boss_died)
		final_boss.hp_changed.connect(_on_boss_hp_changed)
		# Initialize HP display
		if "max_hp" in final_boss and "current_hp" in final_boss:
			var max_hp = final_boss.max_hp
			var current_hp = final_boss.current_hp
			_update_hp_display(current_hp, max_hp)

func _on_boss_died() -> void:
	print("Boss defeated! Opening victory path...")
	# Hide Victory_to_open to allow player to enter portal
	if victory_to_open:
		victory_to_open.queue_free()
	# Hide HP bar when boss dies
	if boss_hp_bar:
		$BossHPUI.queue_free()

func _on_boss_hp_changed(current_hp: int, max_hp: int) -> void:
	_update_hp_display(current_hp, max_hp)
	
	# Kích hoạt BigSpike khi HP <= 30
	if current_hp <= 30 and not big_spike_activated:
		big_spike_activated = true
		if big_spike and big_spike.has_method("start_moving"):
			big_spike.start_moving()
	
	# Đảo chiều BigSpike khi HP <= 20
	if current_hp <= 20 and not big_spike_reverse_triggered:
		big_spike_reverse_triggered = true
		if big_spike and big_spike.has_method("start_reverse"):
			big_spike.start_reverse()
	
	# Thả 4 spike_ball khi HP <= 10
	if current_hp <= 10 and not spike_balls_triggered:
		spike_balls_triggered = true
		for spike_ball in spike_balls:
			if spike_ball and spike_ball.has_method("start_fall"):
				spike_ball.start_fall()

func _update_hp_display(current_hp: int, max_hp: int) -> void:
	if boss_hp_bar:
		boss_hp_bar.max_value = max_hp
		boss_hp_bar.value = current_hp
	if boss_hp_label:
		boss_hp_label.text = "Boss HP: %d / %d" % [current_hp, max_hp]

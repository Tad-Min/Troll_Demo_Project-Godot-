extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer

func _ready():
	var current_scene_path = get_tree().current_scene.scene_file_path
	print("Current scene path: ", current_scene_path)

	# Nếu đang ở menu chính (StartUI), dừng nhạc
	if current_scene_path.contains("StartUI"):
		if music_player.playing:
			print("Đang ở menu → Dừng nhạc")
			music_player.stop()
		return

	# Nếu đang ở level, phát nhạc nếu chưa phát
	if not music_player.playing:
		print("Đang ở level → Phát nhạc")
		music_player.play()
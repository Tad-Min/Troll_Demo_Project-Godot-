extends Node

# LauncherManager - Quản lý chính của Launcher
# Chức năng: Điều phối UpdateChecker và load GameContent

signal game_loaded
signal update_completed
signal launcher_ready

var is_game_loaded = false
var is_update_in_progress = false

func _ready():
	print("🚀 LauncherManager khởi động...")
	
	# Kết nối signals
	UpdateChecker.update_available.connect(_on_update_available)
	UpdateChecker.update_completed.connect(_on_update_completed)
	UpdateChecker.update_failed.connect(_on_update_failed)
	
	# Bắt đầu kiểm tra cập nhật
	await get_tree().create_timer(0.5).timeout
	start_update_check()
	
	launcher_ready.emit()

func start_update_check():
	print("🔍 Bắt đầu kiểm tra cập nhật...")
	is_update_in_progress = true
	UpdateChecker.check_for_updates()

func _on_update_available():
	print("🔄 Có bản cập nhật mới!")
	# Hiển thị UI cập nhật
	show_update_ui()

func _on_update_completed():
	print("✅ Cập nhật hoàn thành!")
	is_update_in_progress = false
	update_completed.emit()
	
	# Load game sau khi cập nhật
	await get_tree().create_timer(1.0).timeout
	load_game()

func _on_update_failed(error_message):
	print("❌ Cập nhật thất bại: ", error_message)
	is_update_in_progress = false
	# Vẫn load game với phiên bản cũ
	await get_tree().create_timer(1.0).timeout
	load_game()

func show_update_ui():
	# Hiển thị UI cập nhật (sẽ được implement trong LauncherUI)
	var launcher_ui = get_tree().current_scene
	if launcher_ui and launcher_ui.has_method("show_update_progress"):
		launcher_ui.show_update_progress()

func load_game():
	print("🎮 Đang load game...")
	
	# Kiểm tra xem có file .pck không
	var pck_path = "user://Game_Troll_Vi_en_lastest.pck"
	
	if FileAccess.file_exists(pck_path):
		print("📦 Tìm thấy file .pck, đang load...")
		if ProjectSettings.load_resource_pack(pck_path):
			print("✅ Load .pck thành công!")
			# Chuyển sang scene chính của game
			change_to_game_scene()
		else:
			print("❌ Không thể load .pck!")
			show_error("Không thể load game content")
	else:
		print("⚠️ Không tìm thấy file .pck, load game mặc định...")
		# Load game từ GameContent folder (cho development)
		load_game_from_folder()

func change_to_game_scene():
	# Chuyển sang scene chính của game
	var game_scene_path = "res://scenes/GameSceneUI/StartUI.tscn"
	
	if ResourceLoader.exists(game_scene_path):
		print("🎯 Chuyển sang scene game: ", game_scene_path)
		get_tree().change_scene_to_file(game_scene_path)
		is_game_loaded = true
		game_loaded.emit()
	else:
		print("❌ Không tìm thấy scene game!")
		show_error("Không tìm thấy scene game")

func load_game_from_folder():
	# Load game từ GameContent folder (cho development)
	var game_scene_path = "../GameContent/scenes/GameSceneUI/StartUI.tscn"
	
	if ResourceLoader.exists(game_scene_path):
		print("🎯 Load game từ folder: ", game_scene_path)
		get_tree().change_scene_to_file(game_scene_path)
		is_game_loaded = true
		game_loaded.emit()
	else:
		print("❌ Không tìm thấy GameContent folder!")
		show_error("Không tìm thấy GameContent")

func show_error(message: String):
	print("❌ Lỗi: ", message)
	# Hiển thị lỗi cho user (sẽ implement trong UI)

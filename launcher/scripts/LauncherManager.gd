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

	var pck_path = "user://Game_Troll_Vi_en_lastest.pck"

	if FileAccess.file_exists(pck_path):
		print("📦 Tìm thấy file .pck, đang chạy lại app...")

		# Android: dùng main-pack flag để khởi động lại với .pck
		if OS.has_feature("android"):
			print("📱 Phát hiện Android, khởi động lại với main-pack")
			var args = ["--main-pack", pck_path]
			OS.set_restart_on_exit(true)
			ProjectSettings.set_setting("application/config/main_pack", pck_path)
			get_tree().quit()
		else:
			print("💻 PC mode - load trực tiếp trong process")
			if ProjectSettings.load_resource_pack(pck_path, true):
				print("✅ Load .pck thành công!")
				get_tree().change_scene_to_file("res://scenes/GameSceneUI/StartUI.tscn")
			else:
				print("❌ Load .pck thất bại!")
	else:
		print("⚠️ Không tìm thấy file .pck, load game mặc định...")
		get_tree().change_scene_to_file("res://scenes/GameSceneUI/StartUI.tscn")


func create_game_autoloads():
	# Tạo các autoload nodes manually vì chúng không được load từ .pck
	# Không gọi _ready() thủ công - để Godot tự gọi sau khi add_child
	print("🔧 Đang tạo GameData autoload...")
	
	if not has_node("/root/GameData"):
		var game_data_script = load("res://scripts/CoreGame/GameData.gd")
		if game_data_script:
			var game_data = game_data_script.new()
			get_tree().root.add_child(game_data)
			game_data.name = "GameData"
			print("✅ GameData node đã được tạo, đợi _ready() được gọi tự động...")
		else:
			print("❌ Không thể load GameData.gd script!")
			return
	
	if not has_node("/root/Session"):
		var session_script = load("res://scripts/CoreGame/Session.gd")
		if session_script:
			var session = session_script.new()
			get_tree().root.add_child(session)
			session.name = "Session"
			print("✅ Session node đã được tạo")
	
	if not has_node("/root/Global"):
		var global_script = load("res://scripts/CoreGame/Global.gd")
		if global_script:
			var global = global_script.new()
			get_tree().root.add_child(global)
			global.name = "Global"
			print("✅ Global node đã được tạo")
	
	# Đợi nhiều frames để Godot tự gọi _ready() cho các nodes
	# _ready() sẽ được gọi tự động trong frame tiếp theo sau add_child
	print("⏳ Đợi _ready() được gọi tự động...")
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	
	# Kiểm tra xem GameData đã được khởi tạo đúng chưa
	if has_node("/root/GameData"):
		var game_data = get_node("/root/GameData")
		# Kiểm tra Levels array đã được khởi tạo chưa (dùng get() thay vì has())
		if game_data.get("Levels") != null and game_data.Levels.size() > 0:
			print("✅ GameData đã được khởi tạo hoàn toàn - Levels size: ", game_data.Levels.size())
		else:
			var levels_size = 0
			if game_data.get("Levels") != null:
				levels_size = game_data.Levels.size()
			print("⚠️ GameData chưa được khởi tạo đầy đủ - Levels size: ", levels_size)
	
	print("✅ Tất cả autoload nodes đã được tạo!")

func change_to_game_scene():
	# Chuyển sang scene chính của game
	var game_scene_path = "res://scenes/GameSceneUI/StartUI.tscn"
	
	# Đảm bảo scene tồn tại trước khi chuyển
	if not ResourceLoader.exists(game_scene_path):
		print("❌ Không tìm thấy scene game!")
		show_error("Không tìm thấy scene game")
		return
	
	# Kiểm tra autoload trước khi change scene
	if has_node("/root/GameData"):
		var game_data = get_node("/root/GameData")
		var current_level = game_data.get("current_level") if game_data.get("current_level") != null else "N/A"
		print("✅ GameData exists, current_level: ", current_level)
	else:
		print("⚠️ GameData chưa tồn tại, có thể gây lỗi!")
	
	print("🎯 Chuyển sang scene game: ", game_scene_path)
	# Change scene và đợi scene được load hoàn toàn
	var error = get_tree().change_scene_to_file(game_scene_path)
	print("📝 Change scene result: ", error)
	if error == OK:
		print("✅ Change scene thành công, đang đợi scene load...")
		# Đợi nhiều frames để đảm bảo scene và autoload được khởi tạo hoàn toàn
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().create_timer(0.2).timeout
		
		is_game_loaded = true
		game_loaded.emit()
		print("✅ Game scene đã được load thành công!")
		
		# Kiểm tra lại GameData sau khi scene load
		if has_node("/root/GameData"):
			var game_data = get_node("/root/GameData")
			var current_level = game_data.get("current_level") if game_data.get("current_level") != null else "N/A"
			print("✅ GameData sau khi load scene - current_level: ", current_level)
	else:
		print("❌ Lỗi khi chuyển scene: ", error)
		show_error("Không thể load scene game - Error code: " + str(error))

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

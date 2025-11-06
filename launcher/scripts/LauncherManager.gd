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
	
	UpdateChecker.update_available.connect(_on_update_available)
	UpdateChecker.update_completed.connect(_on_update_completed)
	UpdateChecker.update_failed.connect(_on_update_failed)
	
	await get_tree().create_timer(0.5).timeout
	start_update_check()
	launcher_ready.emit()


func start_update_check():
	print("🔍 Bắt đầu kiểm tra cập nhật...")
	is_update_in_progress = true
	UpdateChecker.check_for_updates()


func _on_update_available():
	print("🔄 Có bản cập nhật mới!")
	show_update_ui()


func _on_update_completed():
	print("✅ Cập nhật hoàn thành!")
	is_update_in_progress = false
	update_completed.emit()
	
	await get_tree().create_timer(1.0).timeout
	load_game()


func _on_update_failed(error_message):
	print("❌ Cập nhật thất bại: ", error_message)
	is_update_in_progress = false
	
	await get_tree().create_timer(1.0).timeout
	load_game()


func show_update_ui():
	var launcher_ui = get_tree().current_scene
	if launcher_ui and launcher_ui.has_method("show_update_progress"):
		launcher_ui.show_update_progress()


# =========================================================
# 🚀 HÀM CHÍNH ĐỂ CHẠY LẠI GAME SAU UPDATE
# =========================================================
func load_game():
	print("🎮 Đang load game...")
	var pck_path = "user://Game_Troll_Vi_en_lastest.pck"

	if FileAccess.file_exists(pck_path):
		print("📦 Tìm thấy file .pck, khởi động lại với file này...")

		if OS.has_feature("android"):
			# ⚠️ Android không cho phép chạy lại process khác,
			# nên ta chỉ gắn main_pack để Godot tự load khi app restart
			print("📱 Android detected - set main_pack for next run")
			ProjectSettings.set_setting("application/config/main_pack", pck_path)
			OS.set_restart_on_exit(true)
			get_tree().quit()
			return

		else:
			# 💻 PC mode – restart lại chính process
			restart_with_new_pack(pck_path)
			return
	else:
		print("⚠️ Không tìm thấy file .pck, load game mặc định...")
		get_tree().change_scene_to_file("res://scenes/GameSceneUI/StartUI.tscn")


# =========================================================
# ⚙️ CÁCH 2 – Restart lại app (PC) với file .pck mới
# =========================================================
func restart_with_new_pack(pck_path: String):
	print("🔁 Restarting game with new pack:", pck_path)

	var exec_path = OS.get_executable_path()
	var args = ["--main-pack", pck_path]
	var output := []  # Mảng chứa kết quả đầu ra

	print("📦 Executing:", exec_path, args)
	var exit_code = OS.execute(exec_path, args, output, false)  # Godot 4.x syntax

	print("🧾 OS.execute exit code:", exit_code)
	print("🪶 Output:", output)

	if exit_code == 0:
		print("✅ Restart launched successfully! Exiting current process...")
	else:
		push_error("❌ Failed to restart with new .pck, code: " + str(exit_code))

	get_tree().quit()  # Thoát process hiện tại để nhường cho bản mới

# =========================================================
# 🔧 Các hàm phụ (bạn giữ nguyên)
# =========================================================
func create_game_autoloads():
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

	print("⏳ Đợi _ready() được gọi tự động...")
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame

	if has_node("/root/GameData"):
		var game_data = get_node("/root/GameData")
		if game_data.get("Levels") != null and game_data.Levels.size() > 0:
			print("✅ GameData đã được khởi tạo hoàn toàn - Levels size:", game_data.Levels.size())
		else:
			print("⚠️ GameData chưa được khởi tạo đầy đủ!")

	print("✅ Tất cả autoload nodes đã được tạo!")


func change_to_game_scene():
	var game_scene_path = "res://scenes/GameSceneUI/StartUI.tscn"

	if not ResourceLoader.exists(game_scene_path):
		print("❌ Không tìm thấy scene game!")
		show_error("Không tìm thấy scene game")
		return

	if has_node("/root/GameData"):
		var game_data = get_node("/root/GameData")
		var current_level = game_data.get("current_level") if game_data.get("current_level") != null else "N/A"
		print("✅ GameData exists, current_level:", current_level)
	else:
		print("⚠️ GameData chưa tồn tại, có thể gây lỗi!")

	print("🎯 Chuyển sang scene game:", game_scene_path)
	var error = get_tree().change_scene_to_file(game_scene_path)
	print("📝 Change scene result:", error)


func load_game_from_folder():
	var game_scene_path = "../GameContent/scenes/GameSceneUI/StartUI.tscn"

	if ResourceLoader.exists(game_scene_path):
		print("🎯 Load game từ folder:", game_scene_path)
		get_tree().change_scene_to_file(game_scene_path)
		is_game_loaded = true
		game_loaded.emit()
	else:
		print("❌ Không tìm thấy GameContent folder!")
		show_error("Không tìm thấy GameContent")


func show_error(message: String):
	print("❌ Lỗi:", message)

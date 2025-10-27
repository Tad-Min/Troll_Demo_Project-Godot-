extends Node

# UpdateChecker - Kiểm tra và tải cập nhật từ GitHub
# Chức năng: Kiểm tra version, tải file .pck mới

signal update_available
signal update_completed
signal update_failed(error_message: String)
signal download_progress(percent: int)

const CURRENT_VERSION = "1.0.22"  # Phiên bản của Launcher
const VERSION_URL = "https://raw.githubusercontent.com/Tad-Min/Troll_Demo_Project-Godot-/main/Export_file/version.txt"
const UPDATE_URL = "https://raw.githubusercontent.com/Tad-Min/Troll_Demo_Project-Godot-/main/Export_file/Game_Troll_Vi_en_lastest.pck"
const LOCAL_PCK_PATH = "user://Game_Troll_Vi_en_lastest.pck"

var http: HTTPRequest
var http_download: HTTPRequest
var is_checking = false
var is_downloading = false

func _ready():
	# Tạo HTTPRequest node
	http = HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_on_version_request_completed)

func check_for_updates():
	var enable_auto_update = ProjectSettings.get_setting("application/config/enable_auto_update", true)
	if not enable_auto_update:
		print("🚫 Auto update is disabled (via Project Settings).")
		update_completed.emit()
		return
	
	if is_checking or is_downloading:
		print("⚠️ Đang kiểm tra/tải cập nhật...")
		return
	
	print("🌀 Checking for updates...")
	is_checking = true
	
	var error = http.request(VERSION_URL)
	if error != OK:
		print("❌ Lỗi khi gửi request: ", error)
		is_checking = false
		update_failed.emit("Không thể kết nối đến server")

func _on_version_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	is_checking = false
	
	print("Version check response code:", response_code)
	if response_code != 200:
		print("❌ Failed to fetch version file.")
		update_failed.emit("Không thể tải thông tin phiên bản (code: " + str(response_code) + ")")
		return
	
	var remote_version = body.get_string_from_utf8().strip_edges()
	print("Remote version:", remote_version)
	print("Current version:", CURRENT_VERSION)
	
	if remote_version != CURRENT_VERSION:
		print("🔄 New version found! Downloading update...")
		update_available.emit()
		download_update()
	else:
		print("✅ Already up to date.")
		update_completed.emit()

func download_update():
	if is_downloading:
		print("⚠️ Đang tải cập nhật...")
		return
	
	print("⬇️ Bắt đầu tải file .pck...")
	is_downloading = true
	
	http_download = HTTPRequest.new()
	add_child(http_download)
	http_download.request_completed.connect(_on_pck_downloaded)
	
	# Hiển thị progress đơn giản
	download_progress.emit(0)
	print("📥 Đang tải file .pck...")
	
	var error = http_download.request(UPDATE_URL)
	if error != OK:
		print("❌ Lỗi khi tải file: ", error)
		is_downloading = false
		update_failed.emit("Không thể tải file cập nhật")

func _on_download_progress(downloaded: int, total: int):
	# Function này không được sử dụng nữa
	pass

func _on_pck_downloaded(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	is_downloading = false
	
	print("📡 Download response code: ", response_code)
	
	if response_code == 200:
		print("✅ Update downloaded successfully!")
		save_update_file(body)
	else:
		print("❌ Failed to download update, code:", response_code)
		update_failed.emit("Tải file cập nhật thất bại (code: " + str(response_code) + ")")

func save_update_file(data: PackedByteArray):
	print("📦 Đang lưu bản cập nhật...")
	
	var file = FileAccess.open(LOCAL_PCK_PATH, FileAccess.WRITE)
	if file == null:
		print("❌ Không thể tạo file: ", LOCAL_PCK_PATH)
		update_failed.emit("Không thể lưu file cập nhật")
		return
	
	file.store_buffer(data)
	file.close()
	print("Saved update to:", LOCAL_PCK_PATH)
	
	update_completed.emit()

func get_local_version() -> String:
	return CURRENT_VERSION

func get_remote_version() -> String:
	# Trả về version từ lần check cuối (nếu có)
	return ""

func is_update_available() -> bool:
	return is_checking or is_downloading

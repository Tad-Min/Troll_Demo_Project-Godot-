extends Node

const CURRENT_VERSION = "1.0.1"  # phiên bản trong file .apk hiện tại
const VERSION_URL = "https://raw.githubusercontent.com/Tad-Min/Troll_Demo_Project-Godot-/main/Export_file/version.txt"
const UPDATE_URL = "https://drive.google.com/uc?export=download&confirm=t&id=1KbSPYN9SrUOCrbjlK1JyEWynAt6PgNF1"
const LOCAL_PCK_PATH = "user://Game_Troll_Vi_en_lastest.pck"

var http := HTTPRequest.new()
var http_download
var status_label

func _ready():
	# Tìm các node UI trong scene (nếu bạn đặt khác tên thì sửa lại)
	status_label = get_node("StatusLabel")
	var enable_auto_update = ProjectSettings.get_setting("application/config/enable_auto_update", true)
	if not enable_auto_update:
		print("🚫 Auto update is disabled (via Project Settings).")
		if status_label:
			status_label.text = "🚫 Cập nhật đang tắt (Project Settings)."
		return
	
	add_child(http)
	http.connect("request_completed", Callable(self, "_on_version_request_completed"))

	print("🌀 Checking for updates...")
	if status_label:
		status_label.text = "🌀 Đang kiểm tra cập nhật..."

	http.request(VERSION_URL)


func _on_version_request_completed(result, response_code, headers, body):
	print("Version check response code:", response_code)
	if response_code != 200:
		print("❌ Failed to fetch version file.")
		if status_label:
			status_label.text = "❌ Không tải được thông tin phiên bản."
		return
	
	var remote_version = body.get_string_from_utf8().strip_edges()
	print("Remote version:", remote_version)
	print("Current version:", CURRENT_VERSION)
	
	if remote_version != CURRENT_VERSION:
		print("🔄 New version found! Downloading update...")
		if status_label:
			status_label.text = "🔄 Đang tải bản cập nhật..."
		download_update()
	else:
		print("✅ Already up to date.")
		if status_label:
			status_label.text = "✅ Bạn đang dùng bản mới nhất."


func download_update():
	http_download = HTTPRequest.new()
	add_child(http_download)
	http_download.request(UPDATE_URL)
	http_download.connect("request_completed", Callable(self, "_on_pck_downloaded"))
	http_download.connect("request_progress", Callable(self, "_on_download_progress"))



func _on_download_progress(downloaded, total):
	if total > 0:
		var percent = int(downloaded * 100 / total)
		if status_label:
			status_label.text = "⬇️ Đang tải... %d%%" % percent


func _on_pck_downloaded(result, response_code, headers, body):
	if response_code == 303:  # Xử lý chuyển hướng
		for header in headers:
			if header.begins_with("Location:"):
				var redirect_url = header.split(": ")[1]
				print("🔄 Redirecting to:", redirect_url)
				http_download.request(redirect_url)
				return

	if response_code == 200:
		print("✅ Update downloaded successfully!")
		if body.size() < 1024 * 1024:  # Kiểm tra nếu file quá nhỏ (dưới 1MB)
			print("❌ File quá nhỏ, có thể không hợp lệ.")
			if status_label:
				status_label.text = "❌ File tải về không hợp lệ."
		return
		
		var file = FileAccess.open(LOCAL_PCK_PATH, FileAccess.WRITE)
		file.store_buffer(body)
		file.close()
		print("Saved update to:", LOCAL_PCK_PATH)
		
		load_pck()
	else:
		print("❌ Failed to download update, code:", response_code)
		if status_label:
			status_label.text = "❌ Tải thất bại (code %d)" % response_code


func load_pck():
	if Global.has_updated:
		if status_label:
			status_label.text = "✅ Đây là bản mới nhất! Chúc bạn chơi game zui zẻ"
		return
	
	await get_tree().process_frame  # 👈 Cho phép main loop idle trước khi load
	
	if ProjectSettings.load_resource_pack(LOCAL_PCK_PATH):
		print("✅ Loaded update pack successfully!")
		if status_label:
			status_label.text = "✅ Cập nhật thành công! Đang khởi động lại game."
			
			Global.has_updated = true
			await get_tree().create_timer(1.0).timeout
			get_tree().reload_current_scene()
	else:
		print("❌ Failed to load update pack.")
		if status_label:
			status_label.text = "⚠️ Không thể nạp bản cập nhật."

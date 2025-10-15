extends Node

# ⚙️ Cấu hình phiên bản & Firebase
const CURRENT_VERSION = "1.0.1"
const FIREBASE_PROJECT_ID = "game-godot-update"
const FIRESTORE_URL = "https://firestore.googleapis.com/v1/projects/%s/databases/(default)/documents/updates/game_update" % FIREBASE_PROJECT_ID
const LOCAL_PCK_PATH = "user://Game_Troll_Vi_en_lastest.pck"

# 🔧 Biến runtime
var status_label: Label
var http_request: HTTPRequest
var http_download: HTTPRequest

func _ready():
	# 🛑 Ngăn kiểm tra lại nếu đã cập nhật
	if Global.has_updated:
		if status_label:
			status_label.text = "✅ Đây là bản mới nhất! Chúc bạn chơi game zui zẻ"
		print("✅ Game đã cập nhật xong, bỏ qua kiểm tra lại.")
		return

	status_label = get_node_or_null("StatusLabel")
	if status_label:
		status_label.text = "🌀 Đang kiểm tra cập nhật..."

	print("🔍 Checking for updates from Firebase Firestore...")
	check_update()


# 🧩 Gửi request đến Firestore REST API để lấy thông tin phiên bản
func check_update() -> void:
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_firestore_response"))
	http_request.request(FIRESTORE_URL)


# 📦 Xử lý phản hồi từ Firestore
func _on_firestore_response(result, response_code, headers, body):
	if response_code != 200:
		if status_label:
			status_label.text = "❌ Không tải được thông tin phiên bản (code %d)" % response_code
		print("⚠️ Firebase response error:", response_code)
		return

	var json_text: String = body.get_string_from_utf8()
	var parsed = JSON.parse_string(json_text)
	if typeof(parsed) != TYPE_DICTIONARY:
		if status_label:
			status_label.text = "⚠️ Dữ liệu Firebase không hợp lệ."
		print("❌ Invalid JSON:", json_text)
		return

	if not parsed.has("fields"):
		status_label.text = "⚠️ Thiếu dữ liệu 'fields' trong Firestore."
		return

	var fields = parsed["fields"]
	var remote_version = fields["version"]["stringValue"]
	var update_url = fields["file_url"]["stringValue"]

	print("Remote version:", remote_version)
	print("Current version:", CURRENT_VERSION)

	if remote_version != CURRENT_VERSION:
		if status_label:
			status_label.text = "🔄 Phát hiện bản cập nhật mới!"
		print("🔄 New version found, downloading update...")
		download_update(update_url)
	else:
		if status_label:
			status_label.text = "✅ Bạn đang dùng bản mới nhất."
		print("✅ Game is up to date.")


# ⬇️ Tải file .pck mới từ link Firebase
func download_update(url: String) -> void:
	http_download = HTTPRequest.new()
	add_child(http_download)

	# Ghi trực tiếp file tải về vào ổ đĩa
	http_download.set_download_file(LOCAL_PCK_PATH)

	http_download.connect("request_completed", Callable(self, "_on_pck_downloaded"))
	http_download.connect("transfer_progress", Callable(self, "_on_download_progress"))

	var err = http_download.request(url)
	if err != OK:
		push_error("❌ Không thể bắt đầu tải file: %s" % str(err))
		if status_label:
			status_label.text = "⚠️ Lỗi khi bắt đầu tải bản cập nhật."


# 📊 Hiển thị tiến trình tải
func _on_download_progress(from_bytes: int, to_bytes: int, total_bytes: int) -> void:
	if total_bytes > 0:
		var percent := int(to_bytes * 100 / total_bytes)
		if status_label:
			status_label.text = "⬇️ Đang tải... %d%%" % percent


# ✅ Khi tải xong file .pck
func _on_pck_downloaded(result, response_code, headers, body):
	if response_code == 200:
		if status_label:
			status_label.text = "✅ Tải thành công! Đang lưu bản cập nhật..."
		print("✅ Update downloaded successfully -> %s" % LOCAL_PCK_PATH)
		load_pck()
	else:
		if status_label:
			status_label.text = "❌ Lỗi tải bản cập nhật (code %d)" % response_code
		print("❌ Download failed:", response_code)

	# Dọn dẹp node HTTP sau khi xong
	if http_download:
		http_download.queue_free()


# 🔁 Nạp gói .pck mới và reload game
func load_pck() -> void:
	# 🛑 Nếu đã cập nhật thì không reload nữa
	if Global.has_updated:
		print("⚠️ Bỏ qua reload vì đã cập nhật.")
		return

	if ProjectSettings.load_resource_pack(LOCAL_PCK_PATH):
		if status_label:
			status_label.text = "✅ Cập nhật thành công! Đang khởi động lại..."
		print("✅ Loaded update pack successfully.")

		Global.has_updated = true  # 🧠 Ngăn reload lặp
		await get_tree().create_timer(1.0).timeout
		get_tree().reload_current_scene()
	else:
		if status_label:
			status_label.text = "⚠️ Không thể nạp bản cập nhật."
		print("❌ Failed to load update pack.")

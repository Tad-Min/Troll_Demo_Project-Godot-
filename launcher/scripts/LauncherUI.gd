extends Control

# LauncherUI - Giao diện chính của Launcher
# Chức năng: Hiển thị loading, progress update, error messages

@onready var status_label = $VBoxContainer/StatusLabel
@onready var progress_bar = $VBoxContainer/ProgressBar
@onready var loading_animation = $VBoxContainer/LoadingAnimation

var is_updating = false

func _ready():
	print("🎨 LauncherUI khởi động...")
	setup_ui()
	connect_signals()

func setup_ui():
	status_label.text = "🚀 Đang khởi động Launcher..."
	progress_bar.visible = false
	loading_animation.play("loading")

func connect_signals():
	# Kết nối với LauncherManager
	LauncherManager.launcher_ready.connect(_on_launcher_ready)
	LauncherManager.update_completed.connect(_on_update_completed)
	LauncherManager.game_loaded.connect(_on_game_loaded)
	
	# Kết nối với UpdateChecker
	UpdateChecker.download_progress.connect(_on_download_progress)
	UpdateChecker.update_failed.connect(_on_update_failed)

func _on_launcher_ready():
	print("✅ Launcher đã sẵn sàng")
	status_label.text = "🔍 Đang kiểm tra cập nhật..."

func show_update_progress():
	print("🔄 Hiển thị progress cập nhật")
	is_updating = true
	progress_bar.visible = true
	progress_bar.value = 0
	status_label.text = "🔄 Đang tải cập nhật..."

func _on_download_progress(percent: int):
	if is_updating:
		progress_bar.value = percent
		status_label.text = "⬇️ Đang tải... " + str(percent) + "%"

func _on_update_completed():
	print("✅ Cập nhật hoàn thành")
	is_updating = false
	progress_bar.visible = false
	status_label.text = "✅ Cập nhật thành công! Đang khởi động game..."

func _on_game_loaded():
	print("🎮 Game đã được load")
	status_label.text = "🎮 Chào mừng đến với Troll Game!"

func _on_update_failed(error_message: String):
	print("❌ Cập nhật thất bại: ", error_message)
	is_updating = false
	progress_bar.visible = false
	status_label.text = "⚠️ Cập nhật thất bại. Đang load game..."

func show_error(message: String):
	status_label.text = "❌ Lỗi: " + message
	print("❌ UI Error: ", message)

extends Node

# AdMobManager - Quản lý AdMob ads
# Chức năng: Hiển thị banner, interstitial ads

signal ad_initialized
signal interstitial_ad_loaded
signal interstitial_ad_failed_to_load(error: String)
signal interstitial_ad_dismissed
signal banner_ad_loaded
signal banner_ad_failed_to_load(error: String)

var admob_node: Node
var is_initialized = false
var interstitial_ad_id = "ca-app-pub-3940256099942544/1033173712"  # Test ID
var banner_ad_id = "ca-app-pub-3940256099942544/6300978111"  # Test ID

func _ready():
	print("📱 AdMobManager khởi động...")
	setup_admob()

func setup_admob():
	# Tạo Admob node
	var AdmobClass = preload("res://addons/AdmobPlugin/Admob.gd")
	if AdmobClass == null:
		push_error("AdMob plugin script not found at res://addons/AdmobPlugin/Admob.gd")
		return
	admob_node = AdmobClass.new()
	add_child(admob_node)
	
	# Kết nối signals (phù hợp với chữ ký plugin)
	if admob_node.has_signal("initialization_completed"):
		admob_node.initialization_completed.connect(_on_admob_initialization_completed)
	if admob_node.has_signal("interstitial_ad_loaded"):
		admob_node.interstitial_ad_loaded.connect(_on_interstitial_ad_loaded)
	if admob_node.has_signal("interstitial_ad_failed_to_load"):
		admob_node.interstitial_ad_failed_to_load.connect(_on_interstitial_ad_failed_to_load)
	if admob_node.has_signal("interstitial_ad_dismissed_full_screen_content"):
		admob_node.interstitial_ad_dismissed_full_screen_content.connect(_on_interstitial_ad_dismissed)
	if admob_node.has_signal("banner_ad_loaded"):
		admob_node.banner_ad_loaded.connect(_on_banner_ad_loaded)
	if admob_node.has_signal("banner_ad_failed_to_load"):
		admob_node.banner_ad_failed_to_load.connect(_on_banner_ad_failed_to_load)

func initialize():
	if is_initialized:
		print("📱 AdMob đã được khởi tạo")
		return
	if admob_node == null:
		setup_admob()
		if admob_node == null:
			push_error("AdMob node not created; cannot initialize")
			return
	print("📱 Đang khởi tạo AdMob...")
	if admob_node.has_method("initialize"):
		admob_node.initialize()
	else:
		push_error("AdMob node missing initialize() method")

func _on_admob_initialization_completed(status_data):
	print("✅ AdMob khởi tạo thành công!")
	is_initialized = true
	ad_initialized.emit()

func show_interstitial_ad():
	if not is_initialized:
		print("⚠️ AdMob chưa được khởi tạo")
		return
	
	print("📺 Hiển thị interstitial ad...")
	admob_node.load_interstitial_ad()
	await admob_node.interstitial_ad_loaded
	admob_node.show_interstitial_ad()

func show_banner_ad():
	if not is_initialized:
		print("⚠️ AdMob chưa được khởi tạo")
		return
	
	print("📱 Hiển thị banner ad...")
	admob_node.load_banner_ad()
	await admob_node.banner_ad_loaded
	admob_node.show_banner_ad()

func hide_banner_ad():
	if not is_initialized:
		print("⚠️ AdMob chưa được khởi tạo")
		return
	
	print("📱 Ẩn banner ad...")
	admob_node.hide_banner_ad()

func load_interstitial_ad():
	if not is_initialized:
		print("⚠️ AdMob chưa được khởi tạo")
		return
	
	print("📺 Đang tải interstitial ad...")
	admob_node.load_interstitial_ad()

func load_banner_ad():
	if not is_initialized:
		print("⚠️ AdMob chưa được khởi tạo")
		return
	
	print("📱 Đang tải banner ad...")
	admob_node.load_banner_ad()

func _on_interstitial_ad_loaded():
	print("✅ Interstitial ad đã tải xong")
	interstitial_ad_loaded.emit()

func _on_interstitial_ad_failed_to_load(error_code: int):
	print("❌ Interstitial ad tải thất bại: ", error_code)
	interstitial_ad_failed_to_load.emit("Error code: " + str(error_code))

func _on_interstitial_ad_dismissed(_ad_id := ""):
	print("🧹 Interstitial ad đã đóng")
	interstitial_ad_dismissed.emit()

func _on_banner_ad_loaded():
	print("✅ Banner ad đã tải xong")
	banner_ad_loaded.emit()

func _on_banner_ad_failed_to_load(error_code: int):
	print("❌ Banner ad tải thất bại: ", error_code)
	banner_ad_failed_to_load.emit("Error code: " + str(error_code))

func set_interstitial_ad_id(ad_id: String):
	interstitial_ad_id = ad_id
	print("📺 Đã set interstitial ad ID: ", ad_id)

func set_banner_ad_id(ad_id: String):
	banner_ad_id = ad_id
	print("📱 Đã set banner ad ID: ", ad_id)

func is_ad_ready() -> bool:
	return is_initialized

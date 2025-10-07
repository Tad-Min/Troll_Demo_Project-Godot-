extends Node

const CURRENT_VERSION = "1.0.1"  # phiên bản trong file .apk hiện tại
const VERSION_URL = "https://raw.githubusercontent.com/Tad-Min/Troll_Demo_Project-Godot-/main/Export_file/version.txt"
const UPDATE_URL = "https://raw.githubusercontent.com/Tad-Min/Troll_Demo_Project-Godot-/main/Export_file/Game_Troll_Vi_en_lastest.pck"
const LOCAL_PCK_PATH = "user://update.pck"

var http := HTTPRequest.new()

func _ready():
	print("🌀 Checking for updates...")
	add_child(http)
	http.request(VERSION_URL)
	http.connect("request_completed", Callable(self, "_on_version_request_completed"))

func _on_version_request_completed(result, response_code, headers, body):
	print("Version check response code:", response_code)
	if response_code != 200:
		print("❌ Failed to fetch version file.")
		return
	
	var remote_version = body.get_string_from_utf8().strip_edges()
	print("Remote version:", remote_version)
	print("Current version:", CURRENT_VERSION)
	
	if remote_version != CURRENT_VERSION:
		print("🔄 New version found! Downloading update...")
		download_update()
	else:
		print("✅ Already up to date.")

func download_update():
	var http_download := HTTPRequest.new()
	add_child(http_download)
	http_download.request(UPDATE_URL)
	http_download.connect("request_completed", Callable(self, "_on_pck_downloaded"))

func _on_pck_downloaded(result, response_code, headers, body):
	if response_code == 200:
		print("✅ Update downloaded successfully!")
		var file = FileAccess.open(LOCAL_PCK_PATH, FileAccess.WRITE)
		file.store_buffer(body)
		file.close()
		print("Saved update to:", LOCAL_PCK_PATH)
		load_pck()
	else:
		print("❌ Failed to download update, code:", response_code)

func load_pck():
	if ProjectSettings.load_resource_pack(LOCAL_PCK_PATH):
		print("✅ Loaded update pack successfully!")
	else:
		print("❌ Failed to load update pack.")

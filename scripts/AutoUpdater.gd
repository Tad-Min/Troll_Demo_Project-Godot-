extends Node

const UPDATE_URL = "https://raw.githubusercontent.com/Tad-Min/Troll_Demo_Project-Godot-/main/Export_file/Game_Troll_Vi_en_lastest.pck"
const LOCAL_PCK_PATH = "E:/Git_Push/Troll_Demo_Project-Godot-/Export_file/Game_Troll_Vi_en.pck"
const VERSION_URL = "https://raw.githubusercontent.com/Tad-Min/Troll_Demo_Project-Godot-/main/Export_file/version.txt"

var http: HTTPRequest

func _ready():
	print("Checking for updates...")
	http = HTTPRequest.new()
	add_child(http)
	check_for_update()

func check_for_update():
	http.request(VERSION_URL)

func _on_version_check_completed(result, response_code, headers, body):
	if result != OK or response_code != 200:
		print("Failed to check update.")
		load_game()
		return

	var latest_version = body.get_string_from_utf8().strip_edges()
	var current_version = ProjectSettings.get_setting("application/config/version", "0.0.0")

	if latest_version != current_version:
		print("New version available:", latest_version)
		download_pck()
	else:
		print("Game is up to date.")
		load_game()

func download_pck():
	print("Downloading updated .pck...")
	http.disconnect("request_completed", Callable(self, "_on_version_check_completed"))
	http.connect("request_completed", Callable(self, "_on_pck_downloaded"))
	http.request(UPDATE_URL)

func _on_pck_downloaded(result, response_code, headers, body):
	if result == OK and response_code == 200:
		var file = FileAccess.open(LOCAL_PCK_PATH, FileAccess.WRITE)
		file.store_buffer(body)
		file.close()
		print("PCK downloaded successfully!")

		# Tải .pck vừa tải
		if ProjectSettings.load_resource_pack(LOCAL_PCK_PATH):
			print("Loaded new PCK content successfully.")
		else:
			print("Failed to load new PCK.")

	load_game()

func load_game():
	print("Starting main scene...")
	get_tree().change_scene_to_file("res://Main.tscn")

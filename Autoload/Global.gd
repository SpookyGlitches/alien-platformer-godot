extends Node2D

var player_data = null
var bgm_helper = 0

var records = {}
var deaths = 0
var user_path = "user://player_idk.save"

func _ready():
	load_player_data()
	apply_audio_settings()
	
func save():
	var save_game = File.new()
	save_game.open(user_path, File.WRITE)
	print(player_data)
	player_data["Master"] = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	player_data["SFX"] = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	player_data["BGM"] = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("BGM"))
	save_game.store_line(to_json(player_data))
	save_game.close()
	print("Saved!")

func load_player_data():

	var file_data = File.new()
	if ! file_data.file_exists(user_path): # provide template data	

		player_data = {
			"current_level" : 1,
			"Master":0,
			"SFX": 0,
			"BGM": 0,
			"records": initialize_records()
		}
		print("here")
		return
	if file_data.open(user_path, File.READ) != 0: # error in opening the file, idk how to handle this
		get_tree().quit()
		
	print(file_data.file_exists(user_path))	
	player_data = {}
	player_data = parse_json(file_data.get_line())
	file_data.close()

func apply_audio_settings():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),player_data["Master"])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"),player_data["BGM"])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),player_data["SFX"])	

func initialize_records():
	var dict = {}
	for i in range(1,8):
		dict[str(i)] = null
	return dict
	
func save_record(dict):
	var lvl = str(dict.level)
	var time = int(dict.time)
	if player_data.records[lvl] == null || player_data.records[lvl] > time:
		player_data.records[lvl] = time
		save()
	

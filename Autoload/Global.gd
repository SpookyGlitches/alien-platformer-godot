extends Node2D

var current_level
var player_data = null
var bgm_helper = 0
#var lives = 3
var Player
var keyUI

func _ready():
	load_player_data()
	apply_audio_settings()
#	set_game_over()
	pass
#	set_process(true)

#func _process(delta):
#	var LabelNode = 
#	LabelNode.text = str(score)

func save():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var lvl = 1
	if player_data != null:
		lvl = player_data["current_level"]
	var new_dict =  {
		"current_level" : lvl ,
		"Master": AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")),
		"SFX": AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")),
		"BGM": AudioServer.get_bus_volume_db(AudioServer.get_bus_index("BGM")),
	}
	player_data = new_dict
	save_game.store_line(to_json(new_dict))
	save_game.close()

func load_player_data():
	var file_data = File.new()
	if ! file_data.file_exists("user://savegame.save"):
		## create template data
		player_data = {
			"current_level" : 1,
			"Master":0,
			"SFX": 0,
			"BGM": 0,
		}
		return
	if file_data.open("user://savegame.save", File.READ) != 0: ## error in opening the file
		return
	player_data = {}
	player_data = parse_json(file_data.get_line())
	
#func die():
#   lives -= 1
#   if lives <= 0:
#	 game_over()

func apply_audio_settings():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),player_data["Master"])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"),player_data["BGM"])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),player_data["SFX"])	

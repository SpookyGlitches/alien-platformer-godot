extends Node2D

var current_level
var player_data = null
var bgm_helper = 0
<<<<<<< Updated upstream
var Player
var score = 0 setget set_score 
var elapsed = 0.0
onready var start_time = OS.get_ticks_msec()
=======
var records = {}
var deaths = 0
var user_path = "user://player_idk.save"

>>>>>>> Stashed changes
func _ready():
	load_player_data()
	apply_audio_settings()

	pass

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


func _process(delta):
	elapsed += delta
	if elapsed >= 30.0:
		elapsed = 0.0
	get_node("/root/Global/HUD/timestamp").set_text("Timestamp:" +str(elapsed))
#	print("Elapsed time: ", OS.get_timec() - start_time)
func set_score(value):
	score = value
	get_node("/root/Global/HUD/score").set_text("KEYS: "+str(score))

func apply_audio_settings():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),player_data["Master"])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"),player_data["BGM"])
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),player_data["SFX"])	

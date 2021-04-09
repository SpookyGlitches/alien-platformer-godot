extends MarginContainer



var options = ["Master", "BGM", "SFX"]
var past = 0
var choice = 0

var buses_index = {}

func _ready():
	toggle_arrow(options[past],false)	
	initialize()
#	var audio_settings = Pause.get_audio_settings()
#	if audio_settings:
#
	resume_audio()
	pass

func initialize():
	var brr = "CenterContainer/VBoxContainer/"
	var hbox_node
	
	for x in options:
		buses_index[x] = AudioServer.get_bus_index(x)
		hbox_node = get_node(brr+x)
		update_progress_bar(hbox_node.get_node("ProgressBar"), Global.player_data[x])
		adjust_sprite(hbox_node,hbox_node.get_node("Label").get_global_position())
		
	options.append("Back")
	hbox_node = get_node(brr+"Back")
	adjust_sprite(hbox_node,hbox_node.get_node("Label").get_global_position())
#
func adjust_sprite(hbox_node,label_position):
	var sprite = hbox_node.get_node("Sprite")
	sprite.set_global_position(Vector2(label_position.x - 15.0, label_position.y))

func _input(event):
	
	if event.is_action_pressed("ui_down"):
		play_sound("Select")
		if choice < options.size() -1 :
			choice += 1
		else:
			choice = 0	
		toggle_arrow(options[past],true)
		past = choice
		toggle_arrow(options[choice],false)
	elif (event.is_action_pressed("ui_right") || event.is_action_pressed("ui_left")) && choice < 3:
		var db
		if event.is_action_pressed("ui_right"):
			db = 5
		else:
			db = -5
		change_volume(options[choice],db)
	elif event.is_action_pressed("ui_accept") && options[choice] == "Back":
		Global.save()
		play_sound("Enter")

func play_sound(input):
	get_node(input).play()
	
func toggle_arrow(node,hide):
	var sprite = get_node("CenterContainer/VBoxContainer/"+node+"/Sprite")
	if hide:	
		sprite.hide()
	else:
		sprite.show()

func change_volume(option,db):
	var progress_bar = get_node("CenterContainer/VBoxContainer/"+option+"/ProgressBar")
	var total_db = AudioServer.get_bus_volume_db(buses_index[option]) + db
	if total_db <= progress_bar.get_min() -5:
		AudioServer.set_bus_mute(buses_index[option], true)
		update_progress_bar(progress_bar,progress_bar.get_min())
	elif total_db > progress_bar.get_max():
		return
	else:
		AudioServer.set_bus_mute(buses_index[option],false)
		AudioServer.set_bus_volume_db(buses_index[option], total_db)
		update_progress_bar(progress_bar,total_db)
#
func update_progress_bar(progress_bar,db):
	progress_bar.set_value(db)

func resume_audio():
	var audio = get_node("MenuBGM")
	audio.seek(Pause.bgm_helper)

func _on_Enter_finished():
	Global.bgm_helper = get_node("MenuBGM").get_playback_position()
	get_tree().change_scene("res://GUI/MainMenu.tscn")

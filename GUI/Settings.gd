extends MarginContainer



var options = ["Master", "BGM", "SFX"]
var past = 0
var choice = 0
var previous_focus
var buses_index = {}

func _ready():
	initialize()
	get_node("CenterContainer/VBoxContainer/Master").grab_focus()
	resume_audio()
	pass
	
func _on_Option_focused():
	var node = get_focus_owner()
	previous_focus = node
	node.get_node("Sprite").show()
	
func _on_Option_focus_exited():
	play_sound("Select")
	previous_focus.get_node("Sprite").hide()
	
func initialize():
	var hbox_node
	for x in ["Master","BGM","SFX","Back"]:
		hbox_node = get_node("CenterContainer/VBoxContainer/"+x)
		get_node("CenterContainer/VBoxContainer/"+x).connect("focus_entered",self,"_on_Option_focused")
		get_node("CenterContainer/VBoxContainer/"+x).connect("focus_exited",self,"_on_Option_focus_exited")
		adjust_sprite(hbox_node,hbox_node.get_node("Label").get_global_position())	
		if (x != "Back"):
			buses_index[x] = AudioServer.get_bus_index(x)
			update_progress_bar(hbox_node.get_node("ProgressBar"), Global.player_data[x])
			
func adjust_sprite(hbox_node,label_position):
	var sprite = hbox_node.get_node("Sprite")
	sprite.set_global_position(Vector2(label_position.x - 15.0, label_position.y))

func _input(event):
	var node = get_focus_owner()
	if node.get_node("Label").get_text() != "Back":
		if event.is_action_pressed("ui_right"):
			change_volume(node,5)
		elif event.is_action_pressed("ui_left"):
			change_volume(node,-5)
	elif node.get_node("Label").get_text() == "Back" && event.is_action_pressed("ui_accept"):
		Global.save()
		play_sound("Enter")

func play_sound(input):
	get_node(input).play()

func change_volume(node,db):
	get_node("Select").play()
	var progress_bar = node.get_node("ProgressBar")
	var label = node.get_name()
	var total_db = AudioServer.get_bus_volume_db(buses_index[label]) + db
	if total_db <= progress_bar.get_min() -5:
		AudioServer.set_bus_mute(buses_index[label], true)
		update_progress_bar(progress_bar,progress_bar.get_min())
	elif total_db > progress_bar.get_max():
		return
	else:
		AudioServer.set_bus_mute(buses_index[label],false)
		AudioServer.set_bus_volume_db(buses_index[label], total_db)
		update_progress_bar(progress_bar,total_db)
#
func update_progress_bar(progress_bar,db):
	progress_bar.set_value(db)

func resume_audio():
	var audio = get_node("MenuBGM")
	audio.seek(Global.bgm_helper)

func _on_Enter_finished():
	Global.bgm_helper = get_node("MenuBGM").get_playback_position()
	get_tree().change_scene("res://GUI/MainMenu.tscn")
	
	


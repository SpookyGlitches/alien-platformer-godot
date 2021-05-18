extends Control

onready var hbox = get_node("MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer/HBoxContainer")
onready var scroll = get_node("MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer")	

var label

func _ready():
	get_node("MenuBGM").play(Global.bgm_helper)
	populate_hbox()
	get_node("MarginContainer/VBoxContainer/HBoxContainer2/VBoxContainer/ScrollContainer").grab_focus()
	pass 

func populate_hbox():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://GUI/VCR_OSD_MONO_1.001.ttf")
	dynamic_font.size = 16
	for i in range(1,8):
		print(i)
		label = Label.new()
		var x = str(i)
		if Global.player_data["records"][x] == null:
			label.set_text("Level "+str(i)+": --:--:--")
		else:
			label.set_text("Level "+str(i)+": " + format_to_time_string(Global.player_data["records"][x]))
		label.set_align(Label.ALIGN_CENTER)
		label.set("custom_fonts/font", dynamic_font)
		hbox.add_child(label)

func _input(event):
	if Input.is_action_just_pressed("ui_focus_prev"):
		scroll.scroll_vertical = 0
	elif Input.is_action_just_pressed("ui_focus_next"):
		get_node("Select").play()
		scroll.scroll_vertical = 25
	elif Input.is_action_just_pressed("ui_accept") && scroll.scroll_vertical == 25:
		get_node("Enter").play()
	
func format_to_time_string(seconds):
	var hh = int(seconds/3600)
	var mins = int((seconds-hh*3600)/60)
	var secs = int(seconds-hh*3600-mins*60)
	var mils = int(seconds-hh*3600-mins-secs) % 1000
	
	return "%0*d" % [2,hh] + ":"+ "%0*d" %[2,mins] + ":" + "%0*d" %[2,secs] 
	
func _on_Enter_finished():
	Global.bgm_helper = get_node("MenuBGM").get_playback_position()
	get_tree().change_scene("res://GUI/MainMenu.tscn")


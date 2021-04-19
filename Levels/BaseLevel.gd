extends Node2D

const TOTAL_LEVELS = 7

var req_keys = 0
var Fail = preload("res://Screens/Fail/Fail.tscn")
var Intro = preload("res://Screens/Intro/Intro.tscn")
var Dialog = preload("res://GUI/Dialog.tscn")

onready var player = get_node("Player")
var level_number

func _ready():
	pass
	
func initialize(n_keys,lvl_number,limit_right):
	Global.player_data["current_level"] = lvl_number
	Global.save()
	set_req_keys(n_keys)
	set_level_number(lvl_number)
	player.connect("die",self,"_on_Player_die")
	player.set_camera(limit_right)
	get_node("Door/Area2D").connect("body_entered",self,"_on_Door_entered")
	get_node("Fall").connect("body_entered",self,"_on_Body_fall")
	var intro = Intro.instance()
	intro.set_level(lvl_number)
	resume_audio()
	add_child(intro)

func set_req_keys(n_keys):
	req_keys = n_keys
	
func get_req_keys():
	return req_keys
	
func set_level_number(lvl):
	level_number = lvl

func get_level_number():
	return level_number 

func fail():
	Global.bgm_helper = 0
	get_node("AudioStreamPlayer").stop()
	var fail = Fail.instance()
	fail.current_level = get_level_number()
	add_child(fail)

func _on_Player_die():
	fail()

func _on_Body_fall(body):
	if body.get_name() == "Player":
		body.die()

func _on_Door_entered(body):
	if body.get_name() != "Player":
		return
	if body.get_keys() > req_keys:
		var dialog = get_dialog_instance()
		dialog.set_message("Alien: It seems that I still lack keys for this door.")
		add_child(dialog)

	else:
		Global.bgm_helper = get_node("AudioStreamPlayer").get_playback_position()
		if level_number != TOTAL_LEVELS:
			get_tree().change_scene("res://Levels/Level"+str(get_level_number()+1)+".tscn")			
			print("Go inside")
		else:
			play_end_scene()

func play_end_scene():
	get_tree().change_scene("res://Screens/End/End.tscn")

func dialog(string):
	print(string)

func restart_level():
	get_tree().change_scene("res://Levels/"+str(get_level_number())+".tscn")

func resume_audio():
	var audio = get_node("AudioStreamPlayer")
	if(Global.bgm_helper != 0):
		audio.seek(Global.bgm_helper)
	else:
		audio.seek(0)

func get_dialog_instance():
	var dialog = Dialog.instance()
	add_child(dialog)
	return dialog

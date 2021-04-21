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
	var intro = Intro.instance()
	intro.set_level(lvl_number)
	add_child(intro)
	play_audio()

func fail():
	get_node("AudioStreamPlayer").stop()
	var fail = Fail.instance()
	fail.current_level = get_level_number()
	add_child(fail)

func _on_Player_die():
	fail()

func _on_Door_entered(body):
	if body.get_name() != "Player":
		return
	if body.get_keys() < req_keys:
		var dialog = get_dialog_instance()
		dialog.set_message("Alien: It seems that I still lack keys for this door.")
	else:
		var dict = {
			"level": get_level_number(),
			"time": get_node("Stopwatch").get_time()
		}
		Global.save_record(dict)
		if level_number != TOTAL_LEVELS:
			get_tree().change_scene("res://Levels/Level"+str(get_level_number()+1)+".tscn")	
		else:
			play_end_scene()

func play_end_scene():
	get_tree().change_scene("res://Screens/End/End.tscn")

func play_audio():
	var audio = get_node("AudioStreamPlayer")
	audio.play()

func get_dialog_instance():
	var dialog = Dialog.instance()
	add_child(dialog)
	return dialog
	
func set_req_keys(n_keys):
	req_keys = n_keys
	
func get_req_keys():
	return req_keys
	
func set_level_number(lvl):
	level_number = lvl

func get_level_number():
	return level_number 
	

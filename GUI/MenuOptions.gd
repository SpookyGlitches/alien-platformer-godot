extends VBoxContainer

var past 
var options = ["Continue", "NewGame", "Options"]
var choice
var entered = false

func _ready():
	choice = 0
	past = 0
	toggle_arrow(options[past],false)
	resume_audio()

func _input(event):
	if event.is_action_pressed("ui_down") || event.is_action_pressed("crouch"):
		play_sound("Select")
		if choice < options.size() -1 :
			choice += 1
		else:
			choice = 0	
		toggle_arrow(options[past],true)
		past = choice
		toggle_arrow(options[choice],false)
	elif event.is_action_pressed("ui_accept"):
		play_sound("Enter")


func init_game(lvl):
	var err = get_tree().change_scene("res://Levels/Level"+str(lvl)+".tscn")
	if err != OK:
		get_tree().change_scene("res://Levels/Level1.tscn")
	
func toggle_arrow(node,hide):
	var sprite = get_node(node+"/Sprite")
	if hide:	
		sprite.hide()
	else:
		sprite.show()
		
func play_sound(input):
	var aud = get_node(input)
	aud.play()

func resume_audio():
	var audio = get_node("MenuBGM")

	audio.play(Global.bgm_helper)

func _on_Enter_finished():
	var lvl
	if options[choice] == "Continue" || options[choice] == "NewGame":
		Global.bgm_helper = 0
		match options[choice]:
			"Continue":
				lvl = Global.player_data["current_level"]
			"NewGame":
				lvl = 1
		init_game(lvl)
	elif options[choice] == "Options":
		Global.bgm_helper = get_node("MenuBGM").get_playback_position()
		get_tree().change_scene("res://GUI/Options.tscn")	

extends VBoxContainer

func _ready():
	resume_audio()
	get_node("Continue").grab_focus()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		play_sound("Enter")
	elif event.is_action_pressed("ui_focus_next") || event.is_action_pressed("ui_focus_prev"):
		play_sound("Select")

func init_game(lvl):
	Global.bgm_helper = 0
	var err = get_tree().change_scene("res://Levels/Level"+str(lvl)+".tscn")
	if err != OK:
		get_tree().change_scene("res://Levels/Level1.tscn")

func play_sound(input):
	var aud = get_node(input)
	aud.play()

func resume_audio():
	var audio = get_node("MenuBGM")
	audio.play(Global.bgm_helper)

func _on_Enter_finished():
	var text = get_focus_owner().text
	match text:
		"Continue":
			init_game(Global.player_data["current_level"])
		"New Game":
			init_game(1)
		"Settings":
			Global.bgm_helper = get_node("MenuBGM").get_playback_position()
			get_tree().change_scene("res://GUI/Settings.tscn")		


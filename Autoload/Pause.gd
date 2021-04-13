extends CanvasLayer

var is_shown = false

func _ready():
	_show(false)
	pass

func _input(event):
	if event.is_action_pressed("pause"):
		var tree = get_tree()		
		if tree.current_scene.get_name() == "MainMenu" || tree.current_scene.get_name() == "Options" || tree.paused:
			return
		else:
			tree.paused = true
			_show(true)
			get_node("Control/CenterContainer/VBoxContainer/ContinueH/Continue").grab_focus()
	elif is_shown && (event.is_action_pressed("ui_focus_next") || event.is_action_pressed("ui_focus_prev")):
		play_sound("Select")
	elif is_shown && event.is_action_pressed("ui_accept"):
		var tree = get_tree()
		play_sound("Enter")
		tree.paused = false
		# code below sucks
		var x = "Control/CenterContainer/VBoxContainer/"
		if get_node(x+"RestartH/Restart").has_focus():
			tree.change_scene("res://Levels/"+tree.current_scene.get_name()+".tscn")		
		elif get_node(x+"MainMenuH/MainMenu").has_focus():
			tree.change_scene("res://GUI/MainMenu.tscn")
		_show(false)
		Global.bgm_helper = 0
		
func play_sound(input):
	get_node(input).play()

func _show(_bool):
	is_shown = _bool
	if _bool:
		get_child(0).show()
	else:
		get_child(0).hide()

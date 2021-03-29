extends CanvasLayer

var past = -1
var options = ["Continue", "Restart", "Menu"]
var choice = 0
var bgm_helper = 0

func _ready():
	past = 0
	_show(false)
	toggle_arrow(options[choice],false)
	
func _input(event):
	if !(event.is_action_pressed("pause") || event.is_action_pressed("ui_down") || event.is_action_pressed("crouch") || event.is_action_pressed("ui_accept")):
		return
	var tree = get_tree()
	if tree.current_scene.name == "MainMenu" || tree.current_scene.name == "Fail":
		return
	if event.is_action_pressed("pause"):
		tree.paused = !tree.paused
		_show(tree.paused)
	if tree.paused:
		if event.is_action_pressed("ui_down") || event.is_action_pressed("crouch"):
			play_sound("select")
			if choice < options.size() -1:
				choice += 1
			else:
				choice = 0
			toggle_arrow(options[past],true)
			past = choice
			toggle_arrow(options[choice],false)
		elif event.is_action_pressed("ui_accept"):
			play_sound("enter")
			tree.paused = false
			_show(false)
			match options[choice]:
				"Menu":
					tree.change_scene("res://GUI/MainMenu.tscn")
				"Restart":
					tree.change_scene("res://Levels/"+tree.current_scene.get_name()+".tscn")		
					

	
func toggle_arrow(node,hide):
	var sprite = get_node("Control/CenterContainer/VBoxContainer/"+node+"/Sprite")
	if hide:	
		sprite.hide()
	else:
		sprite.show()

func play_sound(input):
	var asset
	match input:
		"select": 
			asset = "res://Audio/select_menu_085.wav"		
		"enter": 
			asset = "res://Audio/enter_menu_150.wav"
	if asset:
		var sfx = load(asset)
		var aud = get_node("Control/AudioStreamPlayer") 
		aud.stream = sfx
		aud.play()

func _show(_bool):
	if _bool:
		get_child(0).show()
	else:
		get_child(0).hide()

extends CanvasLayer

var past = -1
var options = ["Continue", "Restart", "Menu"]
var choice = 0

var is_shown = false


func _ready():
	past = 0
	_show(false)
	toggle_arrow(options[choice],false)

func _input(event):
	if event.is_action_pressed("pause"):
		var tree = get_tree()		
		if tree.current_scene.get_name() == "MainMenu" || tree.current_scene.get_name() == "Options" || tree.paused:
			return
		else:
			tree.paused = true
			_show(true)
	elif is_shown && (event.is_action_pressed("crouch") || event.is_action_pressed("ui_down")):
		play_sound("Select")
		if choice < options.size() -1:
			choice += 1
		else:
			choice = 0
		toggle_arrow(options[past],true)
		past = choice
		toggle_arrow(options[choice],false)
	elif is_shown && event.is_action_pressed("ui_accept"):
		var tree = get_tree()
		play_sound("Enter")
		tree.paused = false
		_show(false)
		Global.bgm_helper = 0
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
	get_node(input).play()

func _show(_bool):
	is_shown = _bool
	if _bool:
		get_child(0).show()
	else:
		get_child(0).hide()

extends CanvasLayer
onready var anim_player = get_node("AnimationPlayer")
var is_done = false

func _ready():
	get_tree().paused = true
	anim_player.play("text")
	get_node("Sprite").hide()
	pass 

func _input(event):
	if event.is_action_pressed("ui_accept") && is_done:
		get_tree().paused = false
		queue_free()
	elif event.is_action_pressed("ui_accept") && (is_done == false):
		anim_player.seek(anim_player.get_current_animation_length()-0.5)

func set_message(msg):
	get_node("ColorRect/ColorRect/HBoxContainer/Label").text = msg

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "text":
		is_done = true
		get_node("Sprite").show()	
		anim_player.play("arrow")

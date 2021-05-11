extends CanvasLayer


func _ready():
	get_tree().set_pause(true)
	get_node("AnimationPlayer").play("IdkAnymore")
	pass 

func _on_AnimationPlayer_animation_finished(_anim_name):
	end_animation()
	pass

func set_level(lvl):
	var node = get_node("ColorRect/CenterContainer/Label")
	node.text = node.text + str(lvl)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		end_animation()

func end_animation():
	get_tree().set_pause(false)
	queue_free()

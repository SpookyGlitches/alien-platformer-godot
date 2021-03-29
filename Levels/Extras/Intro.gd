extends CanvasLayer
var tree

func _ready():
	tree = get_tree()
	tree.paused = true
	get_node("AnimationPlayer").play("IdkAnymore")
	pass 

func _on_AnimationPlayer_animation_finished(anim_name):
	tree.paused = false
	queue_free()
	pass

func set_level(lvl):
	var node = get_node("ColorRect/CenterContainer/Label")
	node.text = node.text + str(lvl)

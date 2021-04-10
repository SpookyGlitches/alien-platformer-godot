extends Node2D

var Dialog = preload("res://GUI/Dialog.tscn")

func _ready():
	$AnimationPlayer.play("walk-to-end")
	pass 


func _physics_process(_delta):
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"walk-to-end":
			get_node("KinematicBody2D/Sprite").play("idle")
			var dialog = Dialog.instance()
			dialog.set_message("Alien: This is probably the end of this place. I hope someone comes for me.")	
			dialog.connect("tree_exited",self,"_on_Dialog_finished")
			add_child(dialog)		
		"end":
			Global.bgm_helper = 0
			get_node("AudioStreamPlayer3").stop()
			get_tree().change_scene("res://GUI/MainMenu.tscn")

func _on_Dialog_finished():
	get_node("AnimationPlayer").play("end")

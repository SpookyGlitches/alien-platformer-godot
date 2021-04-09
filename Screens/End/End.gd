extends Node2D

func _ready():
	$AnimationPlayer.play("end")
	pass 


func _physics_process(_delta):
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	Global.bgm_helper = 0
	get_tree().change_scene("res://GUI/MainMenu.tscn")
	pass 

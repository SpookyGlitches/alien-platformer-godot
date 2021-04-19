extends "res://Autoload/Global.gd"


func _ready():
	pass

func _on_Key_body_entered(body):

	if body.get_name() == "Player":
		get_node("AudioStreamPlayer").play()
		get_node("/root/Global").score += 1
		
func _on_AudioStreamPlayer_finished():
	queue_free()
	pass 
	

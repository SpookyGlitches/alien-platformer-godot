extends Area2D


func _ready():

	pass


func _on_Key_body_entered(body):
#keyCount as Global
#Global.Player.increasedScore
	if body.get_name() == "Player":
		body.collect_key()
		get_node("AudioStreamPlayer").play()

	
func _on_AudioStreamPlayer_finished():
	queue_free()
	pass 
	

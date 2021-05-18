extends Area2D

#onready var tween = get_node("Tween")
func _ready():
#	tween.interpolate_property(get_node("Sprite"),"position",Vector2(0,0),Vector2(0,5),0.5,tween.TRANS_LINEAR,tween.EASE_IN)
#	tween.start()
	pass


func _on_Key_body_entered(body):
	if body.get_name() == "Player":
		body.collect_key()
		get_node("AudioStreamPlayer").play()

func _on_AudioStreamPlayer_finished():
	queue_free()
	pass 
	

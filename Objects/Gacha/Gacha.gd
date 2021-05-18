extends Area2D

#signal load_previous_level

func _ready():
	pass
	
func _on_Gacha_body_entered(body):
	randomize()
	var number = randf()
	if body.get_name() == "Player":
		get_parent()._on_Gacha_enter(number)
	pass

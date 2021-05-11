extends "BaseLevel.gd"


func _ready():
	initialize(1,3,720)




func _on_ForDialog_body_entered(body):
	if body.get_name() == "Player":
		var dialog = get_dialog_instance()
		dialog.set_message("Alien: This is getting out of hand. This door needs 2 keys!")
		get_node("ForDialog").queue_free()
	pass # Replace with function body.

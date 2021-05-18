extends "BaseLevel.gd"

func _ready():
	initialize(1,1,672)

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		var dialog = get_dialog_instance()
		dialog.set_message("Alien: This seems silly. Why can't I just jump over on this door? Who needs a key for this?!")
		get_node("Area2D").queue_free()
	pass # Replace with function body.

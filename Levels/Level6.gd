extends "BaseLevel.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	initialize(3,6,960)
	get_node("Potion").connect("reveal_keys",self,"_on_Potion_collect")
	make_keys_invisible(true)
	pass

func make_keys_invisible(my_bool):
	var node
	for number in range(req_keys):
		node = get_node("Key"+str(number+1))
		node.get_node("CollisionShape2D").set_deferred("disabled", my_bool)
		if my_bool:
			node.hide()
		else:
			node.show()
			
func _on_Potion_collect():
	make_keys_invisible(false)
	

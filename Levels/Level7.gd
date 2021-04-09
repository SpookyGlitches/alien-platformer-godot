extends "BaseLevel.gd"

onready var Bat = preload("res://Actors/Bat/Bat.tscn")


func _ready():
	initialize(3,7,960)
	get_node("Potion").connect("reveal_keys",self,"_on_Potion_collect")
	player.connect("die",self,"_on_Player_die")
	make_keys_invisible(true)
	pass


func _on_Player_die():
	get_node("Timer").stop()
	fail()

func _on_Timer_timeout():
	var bat = Bat.instance()
	bat.position.x = player.position.x - 200
	add_child(bat)
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


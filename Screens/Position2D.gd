extends Position2D

export(int)var speed: int = 20

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= speed * delta 
	elif Input.is_action_pressed("ui_down"):
		position.y += speed * delta
	elif Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("ui_right"):
		position.x += speed * delta 
	print(position) 


extends Area2D


#var walk_speed = 1
#var velocity = Vector2.ZERO
#var collision
onready var anim_sprite = get_node("AnimatedSprite")
var reverse = 1

func _ready():
	idle()

func _physics_process(delta):
	position.x += (1 * reverse) 
	pass

func idle():
	set_physics_process(false)
	anim_sprite.play("idle")

func active():
	set_physics_process(true)
	anim_sprite.play("active")

func _on_Mob_body_entered(body):
	if body.get_name() == "Player":
		body.die()
	else:
		reverse *= -1

func _on_Timer_timeout():
	idle()


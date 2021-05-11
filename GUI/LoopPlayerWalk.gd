extends KinematicBody2D



var walk_speed = 1
var velocity = Vector2.ZERO
var collision
onready var anim_sprite = get_node("AnimatedSprite")

func _ready():
	anim_sprite.play("walk")
	pass

func _physics_process(_delta):
	velocity.x = walk_speed
	collision = move_and_collide(velocity)
	if collision:
		anim_sprite.flip_h = !anim_sprite.flip_h
		walk_speed = walk_speed * -1

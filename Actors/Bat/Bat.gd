extends Area2D


var player
var collision
var speed
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Player") 
	var rand_generate = RandomNumberGenerator.new()
	rand_generate.randomize()
	speed = rand_generate.randi_range(50,65)
	player.connect("die",self,"_on_Player_die")
	get_node("AudioStreamPlayer2D").play(0.0)
	print(speed)

func _process(delta):
	position += (player.position - self.position).normalized() * speed * delta

func _on_Player_die():
	queue_free()

func _on_Bat_body_entered(body):
	if body.get_name() == "Player":
		body.die()
		queue_free()
	pass 

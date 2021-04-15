extends CanvasLayer


var time = 0.0
onready var label = get_node("Label")

func _ready():
	stop()
	start()
	pass

func _process(delta):
	time += delta
	label.set_text(str(int(get_time())))

func start():
	set_process(true)

func get_time():
	return time

func stop():
	set_process(false)

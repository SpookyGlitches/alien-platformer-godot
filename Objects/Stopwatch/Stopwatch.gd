extends CanvasLayer


var time = 0.0

onready var label = {
	get_node("Label"): 
	OS.get_time()
}

func _ready():
	stop()
	start()
	pass

func _process(delta):
	time += delta
	get_node("Label").set_text("Timestamp: "+str(time))

func start():
	set_process(true)

func get_time():
	return time

func stop():
	set_process(false)

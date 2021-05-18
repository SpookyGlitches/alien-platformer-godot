extends Label

var time = 0.0
#onready var label = get_node("Label")
var timer_on = false
var time_passed

func _process(delta):
	if(timer_on):
		time += delta

	#get_node("Label").set_text("Timestamp: "+str(time))
	var mils = fmod(time,1) *100
	var secs = fmod(time,60)
	var mins = fmod(time, 60*60)/60
	#var hr = fmod(fmod(time,3600 * 60) / 3600,24)
	time_passed ="%02d : %02d : %02d" % [mins,secs, mils]
	text = time_passed
	
	pass
#	label.set_text(time_passed) 
func _ready():
	stop()
	start()
	pass	
	
func start():
	#set_process(true)
	timer_on = true
	
func get_time():
	return time_passed

func stop():
	timer_on = false

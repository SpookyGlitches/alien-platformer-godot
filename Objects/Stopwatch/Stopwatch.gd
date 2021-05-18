extends Label

var time = 0.0
var timer_on = false
var time_passed

func _process(delta):
	if(timer_on):
		time += delta
	
	var mils = fmod(time,1) *100
	var secs = fmod(time,60)
	var mins = fmod(time, 60*60)/60
	time_passed ="%02d : %02d: %02d" % [mins,secs, mils]
	text = time_passed
	print(time)
	pass
	
func _ready():
	stop()
	start()
	pass	
	
func start():
	timer_on = true
	
func get_time():
	
	return time

func stop():
	timer_on = false

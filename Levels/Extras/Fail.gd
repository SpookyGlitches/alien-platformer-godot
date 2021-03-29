extends CanvasLayer

var current_level

func _ready():
	get_node("Timer").connect("timeout", self, "_on_Fail_timeout")

func _on_Fail_timeout():
	get_tree().change_scene("res://Levels/Level"+str(current_level)+".tscn")



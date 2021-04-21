extends Label
onready var sprite = get_node("Sprite")

func _ready():
	adjust_sprite()

func adjust_sprite():
	sprite.set_global_position(Vector2(self.get_global_position().x - 15.0, self.get_global_position().y))

func _on_Label_focus_entered():
	sprite.show()

func _on_Label_focus_exited():
	sprite.hide()


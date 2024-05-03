extends Sprite2D

var macsharePath = "res://art/mainScreen/macshare.svg"
var daysToShow = "res://art/mainScreen/daysToShow.svg"


func _ready():
	update()

func update():
	if (GameVariables.days_remaining <= 3):
		set_texture(load(daysToShow))
		$Label.set_text(str(GameVariables.days_remaining))
		$Label.visible = true
	else:
		set_texture(load(macsharePath))
		$Label.visible = false

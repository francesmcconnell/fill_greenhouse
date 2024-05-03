extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	update_display()


func update_display():
	$CalendarText.set_text(str(GameVariables.days_remaining))

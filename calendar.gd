extends Area2D

# Reset the calendar text. Set up the calendar to listen for the next day transition.
func _ready():
	$Label.set_text(str(GameVariables.days_remaining))
	get_parent().connect("nextDay", next_day.bind())


# If the calendar is clicked, switch to the calendar screen.
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().root.get_node("Root").set_scene("res://calendar_screen.tscn")


# When next day is triggered, decrement days remaining and reset the label
func next_day():
	GameVariables.days_remaining -= 1
	GameVariables.days_passed += 1
	print("Day "+ str(GameVariables.days_passed))
	$Label.set_text(str(GameVariables.days_remaining))

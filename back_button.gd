extends Area2D

func _on_input_event(_viewport, event, _shape_idx):
	var rootNode = get_tree().root.get_node("Root")
	
	# If the timer is not running (if a button was not just clicked) and the back button is clicked, reset the scene
	if rootNode.get_node("Timer").is_stopped() and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		rootNode.set_scene_back()

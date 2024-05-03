extends Sprite2D

# Play a fade-to-black animation to signal time between days
func fade_to_black():
	visible = true
	$BlackScreenPlayer.play("fade_to_black")


# When the black screen is showing, no other clicking is allowed
func _input(_event: InputEvent):
	if is_visible():
		get_viewport().set_input_as_handled()


# When the next day animation is finished, set the black screen to invisible
func _on_animation_player_animation_finished(_anim_name):
	visible = false

extends Node2D
const PotResouce = preload("res://pot.tscn")
var isInitialized = false
signal nextDay

const PotPosition = [
	Vector2(-826, 154), 
	Vector2(-602, 67), 
	Vector2(-273, -4), 
	Vector2(3, -3), 
	Vector2(260, -6), 
	Vector2(595, 65), 
	Vector2(814, 154)]
	
# Initialize the pots if necessary and update their graphics
func _ready():
	$Calendar._ready()
	$Poster._ready()
	$VolumeButton._ready()
	if !isInitialized:
		initializePots()
	for i in range(7):
		get_node("Pot" + str(i)).update()


func initializePots():
	# Default each plant to a pot with no soil and a LadySlipper without seeds
	for x in range(7):
			GameVariables.soilPathIndicies.append(0)
			GameVariables.plantStates.append(GameVariables.initialStates[GameVariables.Species.LadySlipper])
			nextDay.connect(get_node("Pot" + str(x))._animation_finished)
	nextDay.connect(get_node("Poster").update)
	isInitialized = true

# When the next day button is clicked, fade to black. Transition to end game if it is the last day.
func _on_next_day_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$BlackScreen.fade_to_black()
		if GameVariables.days_remaining == 1:
			get_tree().root.get_node("Root").set_scene("res://end_screen.tscn")

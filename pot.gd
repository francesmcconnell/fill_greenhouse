extends Area2D

@export var number : int;

# Health variables
var wateredNum:int =0;
var yesWaterNum:int = 0;
var waterConst = GameVariables.waterConst
var waterNeed = GameVariables.waterNeeds[number]
var health:float = 0.75


# average water model
var totalWater:float = 0;
var waterAvg:float;
var waterHealth:float = 0.75
var waterLB:float = GameVariables.waterNeedsList[number][0]
var waterUB:float = GameVariables.waterNeedsList[number][1]
var waterTypical:float = GameVariables.waterNeedsList[number][2]
var daysPassed = 0


# Temperature variables
var tempHealth = 0.75;
var tempLB:float = GameVariables.tempRanges[number][0]
var tempUB:float = GameVariables.tempRanges[number][1]
var tempTypical:int = GameVariables.tempRanges[number][2]
var tempConst = GameVariables.tempConst

# Connect this pot to the black button so that when the next day is triggered, _animation_finished() runs
func _ready():
	pass


# Redraw the correct plant and soil sprites
func update():
	$plant.set_texture(load(GameVariables.plantStates[number].path))
	$soil.set_texture(load(GameVariables.possibleSoilPaths[GameVariables.soilPathIndicies[number]]))


# If the pot is clicked, set the active plant to this pot number and switch the workbench screen
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameVariables.activePlant = number
		get_tree().root.get_node("Root").set_scene("res://workbench_screen.tscn")


# When the screen is black, update the pot health and plant state
func _animation_finished():
	
	# If the current plant state is not the inital state for this species (if the pot is not empty), update health
	var currentState = GameVariables.plantStates[number]
	if(currentState != GameVariables.initialStates[currentState.species]):
		change_Health()
		reset_wateredNum() #TODO: Confirm this is correct
	
	GameVariables.plantStates[number] = GameVariables.plantStates[number].get_next_state(health)
	$plant.set_texture(load(GameVariables.plantStates[number].path))
	update()


# Health related functions
func increase_wateredNum():
	wateredNum=wateredNum+1
	totalWater = totalWater +1
	print(totalWater)
	 
# Resets variables for the pot after being thrown out
func reset_pot():
	totalWater = 0
	daysPassed = 0
	waterHealth = 0.75
	tempHealth = 0.75
	health = 0.75

# Resets the waterNum
func reset_wateredNum():
	wateredNum=0

# Uses the upper and lower bounds the temperature health for the plant found in 
# Gamevariables to detrimne whter to increase or decrease temperature health
func change_temp_health():
	if(GameVariables.temperature>= tempLB and GameVariables.temperature<=tempUB):
		if tempHealth >=(1-tempConst):
			tempHealth = 1
		else:
			tempHealth = tempHealth+tempConst
	else:
		var diff
		if(GameVariables.temperature<tempLB):
			diff = tempLB-GameVariables.temperature
		else:
			diff = GameVariables.temperature-tempUB
		tempHealth = tempHealth-(diff*diff*tempConst/25)
	if(tempHealth<tempConst):
		tempHealth=0

# Changes the water component of the health
func change_water_health():
	waterAvg = totalWater/ daysPassed
	if(waterAvg>= waterLB and waterAvg<=waterUB):
		if waterHealth >=(1-waterConst):
			waterHealth = 1
		else:
			waterHealth = waterHealth+waterConst
	else:
		var diff = abs(waterAvg-waterTypical)
		if(diff<1 ):
			waterHealth -= waterConst
		else:
			waterHealth-= 2*waterConst
		if(waterHealth<=(waterConst)):
			waterHealth = 0
			


# Change Health with average 
func change_Health():
	print("-------------------------------------------")
	daysPassed=daysPassed+1
	print("Old Health for Pot" +str(number)+": "+ str(health))
	change_water_health()
	change_temp_health()
	print("Total Water: " + str(totalWater))
	print("Total Days: "+ str(daysPassed))
	print("Water per Day: " + str(waterAvg))
	print("Times Watered Today: "+ str(wateredNum))
	print("Water Health: "+ str(waterHealth))
	#print("Temperature Health: "+ str(tempHealth))
	#print("Temperature Lower Bound: "+ str(tempLB))
	#print("Temperature Upper Bound: "+ str(tempUB))
	#print("Actual Temperature: "+ str(GameVariables.temperature))

	health = waterHealth*0.5 +tempHealth*0.5
	print("New Health for Pot" +str(number)+": "+ str(health))


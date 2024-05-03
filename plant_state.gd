extends Object

var species : GameVariables.Species
var path : String
var nextStates = {}

var stateName: String
var thisSpecies: String


func add_next_state(newNextState, nextStateProbability: float):
	nextStates[newNextState] = nextStateProbability

func remove_next_state(state): 
	nextStates.erase(state)

func set_state_name(state):
	stateName=state

# Adjusts the probability of moving to the next state based off of plant health
func get_next_state(health):
	var nextStateKeys = GameVariables.stateMachineData[species].get(stateName).keys()
	var count:int=0
	for state in nextStates:
		var currentState = nextStateKeys[count]
		print("Current State: " + currentState)
		var nextStateProb: float = nextStates.get(state)
		var randNum = randf()
		if(currentState.contains("Dying") or currentState.contains("Dead")):
			nextStateProb=nextStateProb/health
		else:
			nextStateProb = nextStateProb*health
		if randNum < nextStateProb:
			return state
		count = count +1
	return self

#func get_next_state():
	#for state in nextStates:
		#if randf() < nextStates.get(state):
			#return state
	#return self

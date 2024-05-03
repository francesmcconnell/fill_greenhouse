extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture(load(GameVariables.plantStates[GameVariables.activePlant].path))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func resetPlant():
	var currentSpecies = GameVariables.plantStates[GameVariables.activePlant].species
	GameVariables.plantStates[GameVariables.activePlant] = GameVariables.initialStates[currentSpecies]
	_ready()

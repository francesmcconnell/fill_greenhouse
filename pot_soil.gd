extends Sprite2D
var collisionShapes

# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture(load(GameVariables.possibleSoilPaths[GameVariables.soilPathIndicies[GameVariables.activePlant]]))
	collisionShapes = [get_parent().get_node("collisionSoilEmpty"), get_parent().get_node("collisionSoilFull"), get_parent().get_node("collisionSoilOverfull1"), get_parent().get_node("collisionSoilOverfull2")]
	for x in range(4):
		if x == GameVariables.soilPathIndicies[GameVariables.activePlant]:
			collisionShapes[x].set_disabled(false)
		else:
			collisionShapes[x].set_disabled(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_state():
	var soilPathIndex = GameVariables.soilPathIndicies[GameVariables.activePlant]
	if soilPathIndex < 3:
		collisionShapes = [get_parent().get_node("collisionSoilEmpty"), get_parent().get_node("collisionSoilFull"), get_parent().get_node("collisionSoilOverfull1"), get_parent().get_node("collisionSoilOverfull2")]
		collisionShapes[soilPathIndex].set_disabled(true)
		collisionShapes[soilPathIndex + 1].set_disabled(false)
		GameVariables.soilPathIndicies[GameVariables.activePlant] = soilPathIndex + 1
		set_texture(load(GameVariables.possibleSoilPaths[GameVariables.soilPathIndicies[GameVariables.activePlant]]))

func remove_soil():
	var soilPathIndex = GameVariables.soilPathIndicies[GameVariables.activePlant]
	if soilPathIndex > 0:
		collisionShapes = [get_parent().get_node("collisionSoilEmpty"), get_parent().get_node("collisionSoilFull"), get_parent().get_node("collisionSoilOverfull1"), get_parent().get_node("collisionSoilOverfull2")]
		collisionShapes[soilPathIndex].set_disabled(true)
		collisionShapes[soilPathIndex - 1].set_disabled(false)
		GameVariables.soilPathIndicies[GameVariables.activePlant] = soilPathIndex - 1
		set_texture(load(GameVariables.possibleSoilPaths[GameVariables.soilPathIndicies[GameVariables.activePlant]]))

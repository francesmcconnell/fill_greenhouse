extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var currentSpecies = GameVariables.plantStates[GameVariables.activePlant].species
	$topPacket/topPacket.set_texture(load(GameVariables.smallPacketPaths[currentSpecies]))
	$bottomPacket/bottomPacket.set_texture(load(GameVariables.smallPacketPaths[(currentSpecies + 1) % 3]))
	$seeds.set_texture(load(GameVariables.speciesPaths[currentSpecies] + GameVariables.speciesNames[currentSpecies] + "0.svg"))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().root.get_node("Root").set_scene("res://rack_screen.tscn")

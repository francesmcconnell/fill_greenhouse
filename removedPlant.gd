extends Sprite2D

func setTexture():
	set_texture(load(GameVariables.plantStates[GameVariables.activePlant].path))

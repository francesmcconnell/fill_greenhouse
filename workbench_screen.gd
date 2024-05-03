extends Node2D

var isDraggingShovel = false
var isShovelInsideSoil = false
var isShovelInsidePot = false
var isMouseInsideShovel = false
var isAnimating = false
var initialShovelPosition = Vector2(1600, 870)
var offset: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	$potSoil/potSoilSprite._ready()
	$rack._ready()
	$plant._ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_released("click"):
		$shovel.scale = Vector2(1, 1)
		
	if !isAnimating and !isShovelInsidePot and !isShovelInsideSoil and Input.is_action_just_released("click"):
		var tween = get_tree().create_tween()
		tween.tween_property($shovel, "position", initialShovelPosition, 1)
		isDraggingShovel = false
	
	if !isAnimating:
		if isMouseInsideShovel and Input.is_action_just_pressed("click"):
			$shovel.scale = Vector2(1.1, 1.1)
			offset = get_global_mouse_position() - $shovel.global_position
			isDraggingShovel = true
		if isDraggingShovel and Input.is_action_pressed("click"):
			$shovel.global_position = get_global_mouse_position() - offset
		if isShovelInsideSoil and Input.is_action_just_released("click"):
			isShovelInsideSoil = false
			isDraggingShovel = false
			if (GameVariables.soilPathIndicies[GameVariables.activePlant] < 3):
				isAnimating = true
				await $shovel.add_soil()
			else:
				var tween = get_tree().create_tween()
				tween.tween_property($shovel, "position", initialShovelPosition, 1)		
		if isShovelInsidePot and Input.is_action_just_released("click"):
			isShovelInsidePot = false
			isDraggingShovel = false
			if (GameVariables.soilPathIndicies[GameVariables.activePlant] > 0):
				isAnimating = true
				await $shovel.remove_soil()
			else:
				var tween = get_tree().create_tween()
				tween.tween_property($shovel, "position", initialShovelPosition, 1)

func plant_seeds(species: GameVariables.Species):
	isAnimating = true
	if GameVariables.soilPathIndicies[GameVariables.activePlant] == 0:
		$rack/AnimationPlayer.play("fail_plant_seeds")
		await $rack/AnimationPlayer.animation_finished
	else:
		$rack/AnimationPlayer.play("plant_seeds")
		await $rack/AnimationPlayer.animation_finished
		GameVariables.plantStates[GameVariables.activePlant].species = species
		GameVariables.plantStates[GameVariables.activePlant] = GameVariables.possiblePlantStates[GameVariables.speciesNames[species] + "0"]
		$plant._ready()
	isAnimating = false
	
func _input(event: InputEvent):
	if isAnimating and event is InputEventMouseButton:
		get_viewport().set_input_as_handled()

func _on_soil_bag_area_entered(area):
	if !isAnimating and area == $shovel:
		isShovelInsideSoil = true

func _on_soil_bag_area_exited(area):
	if area == $shovel:
		isShovelInsideSoil = false


func _on_shovel_mouse_entered():
	isMouseInsideShovel = true

func _on_shovel_mouse_exited():
	isMouseInsideShovel = false


func _on_pot_soil_area_entered(area):
	if !isAnimating and area == $shovel:
		isShovelInsidePot = true

func _on_pot_soil_area_exited(area):
	if area == $shovel:
		isShovelInsidePot = false

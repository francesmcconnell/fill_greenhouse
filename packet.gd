extends Area2D
var active = false
var frontShowing = true
var isAnimating = false
@export var order:int #1 denotes front, 3 denotes back
@export var species:GameVariables.Species

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("../xMark").connect("input_event", Callable(self, "_on_xMark_input_event"))
	get_node("../checkMark").connect("input_event", Callable(self, "_on_checkMark_input_event"))
	if order == 1:
		z_index = 4
		position.y = 540
	elif order == 2:
		z_index = 2
		position.y = 520
	elif order == 3:
		z_index = 1
		position.y = 500


func _on_input_event(_viewport, event, _shape_idx):
	# On input, if this is the top packet, foreground and flip the packet
	if event is InputEventMouseButton and !event.pressed:
		if order == 1:
			isAnimating = true
			if !active: 
				$AnimationPlayer.play("foreground")
				await $AnimationPlayer.animation_finished
				active = true
			if frontShowing:
				$AnimationPlayer.play("flip_backward")
			else:
				$AnimationPlayer.play("flip_forward")
			await $AnimationPlayer.animation_finished
			isAnimating = false 
			frontShowing = !frontShowing
			
func _on_xMark_input_event(_viewport, event, _shape_idx):
	# If the xMark is clicked and an animation did not immediately finish playing
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if get_tree().root.get_node("Root/Timer").is_stopped():
			isAnimating = true
			# Animate this packet based on its order and update order.
			if order == 1:
				if !frontShowing:
					$AnimationPlayer.play("flip_forward")
				$AnimationPlayer.play("swipe_left")
				await $AnimationPlayer.animation_finished
				get_parent().move_child(self, 1)
				order = 3
			elif order == 2:
				$AnimationPlayer.play("move_to_front")
				await $AnimationPlayer.animation_finished
				order = 1
			elif order == 3:
				$AnimationPlayer.play("move_to_middle")
				await $AnimationPlayer.animation_finished
				active = false
				order = 2
			isAnimating = false


func _on_checkMark_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var rootNode = get_tree().root.get_node("Root")
	
		var mainScreen = rootNode.get_node("MainScreen")
		var currentPot = mainScreen.get_node("Pot"+str(GameVariables.activePlant))
		
		# If this is the top packet and an animation did not immediately finish playing, play the swipe_right animation and switch to the workbench
		if rootNode.get_node("Timer").is_stopped() and order == 1:
			isAnimating = true
			$AnimationPlayer.play("swipe_right")
			await $AnimationPlayer.animation_finished
			isAnimating = false
			GameVariables.plantStates[GameVariables.activePlant] = GameVariables.possiblePlantStates[GameVariables.speciesNames[species] + "Blank"]
			rootNode.set_scene("res://workbench_screen.tscn")
			$AnimationPlayer.play("RESET")
			await rootNode.get_node("WorkbenchScreen").plant_seeds(species)


# Prevent input while the packet is animating
func _input(_event: InputEvent):
	if isAnimating:
		get_viewport().set_input_as_handled()

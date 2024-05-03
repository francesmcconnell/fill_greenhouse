extends Area2D

var isAnimating = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		isAnimating = true
		
		# Getting current pot
		var mainScreen = get_tree().root.get_node("Root/MainScreen")
		var currentPot = mainScreen.get_node("Pot"+str(GameVariables.activePlant))
		currentPot.increase_wateredNum()

		$AnimationPlayer.play("watering")
		await $AnimationPlayer.animation_finished


func _input(_event: InputEvent):
	if isAnimating:
		get_viewport().set_input_as_handled()

func _on_animation_player_animation_finished(_anim_name):
	isAnimating = false

extends Node2D
var playing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update():
	if playing:
		$VolumeButton/Sprite2D.set_texture(load("res://art/volumeButton.svg"))
		get_tree().root.get_node("/root/MusicStreamPlayer").set_stream_paused(false)
	else:
		$VolumeButton/Sprite2D.set_texture(load("res://art/muteButton.svg"))
		get_tree().root.get_node("/root/MusicStreamPlayer").set_stream_paused(true)

func _on_volume_button_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		playing = !playing
		update()

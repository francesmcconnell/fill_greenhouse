extends AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func emit_nextDay():
	get_tree().root.get_node("/root/Root/MainScreen").emit_signal("nextDay")

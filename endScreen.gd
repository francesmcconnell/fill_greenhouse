extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Pot0.update()
	$Pot1.update()
	$Pot2.update()
	$Pot3.update()
	$Pot4.update()
	$Pot5.update()
	$Pot6.update()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


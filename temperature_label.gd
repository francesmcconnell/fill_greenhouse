extends Label

var min_temp = 32
var max_temp = 99
var min_pos_y = 325 # Lowest positioj
var max_pos_y = -5 # Highest position

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text(str(GameVariables.temperature))
	update_thermometer()

func update_thermometer():
	var temp_fraction = float(GameVariables.temperature - min_temp) / (max_temp - min_temp)
	var thermometer_fill_node = get_node("../ThermometerMoving")
	var new_pos_y = min_pos_y + temp_fraction * (max_pos_y - min_pos_y)
	thermometer_fill_node.position.y = new_pos_y
	set_text(str(GameVariables.temperature))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func increase_temp():
	if GameVariables.temperature < 99:
		GameVariables.temperature += 1
		set_text(str(GameVariables.temperature))
		update_thermometer()

func decrease_temp():
	if GameVariables.temperature > 32:
		GameVariables.temperature -= 1
		set_text(str(GameVariables.temperature))
		update_thermometer()
	

func _on_up_button_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		increase_temp()


func _on_down_button_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		decrease_temp()

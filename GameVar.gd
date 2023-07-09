extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Car.current_mode == 0:
		self.text = Car.var_strings_Race[Car.current_var]
	elif Car.current_mode == 1:
		self.text = Car.var_strings_Timed[Car.current_var]
	else:
		self.text = Car.var_strings_Endless[Car.current_var]

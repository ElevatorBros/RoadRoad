extends CheckButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.button_pressed:
		var scene = load("res://main.tscn").instantiate()
		get_parent().find_child("Label").hide()
		self.hide()
		get_tree().get_root().add_child(scene)
		

		self.button_pressed = false
		

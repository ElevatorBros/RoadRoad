extends Label

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameStarter.start_game:
		if not Car.has_died:
			time += delta
			self.text = str(time).pad_decimals(2)

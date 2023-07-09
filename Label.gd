extends Label

var time = 0

var set_time = false

# Called when the node enters the scene tree for the first time.
func _ready():
	time = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameStarter.start_game:
		if not Car.has_died:
			if Car.is_timed:
				if not set_time:
					time = Car.time_to_win
					set_time = true
				else:
					time -= delta
			else:
				time += delta
			self.text = str(time).pad_decimals(2)

	if time < 0:
		self.text = str(0).pad_decimals(2)
		Car.win()
		
	if Car.is_zen:
		self.visible = false

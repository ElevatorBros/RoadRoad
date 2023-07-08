extends Camera2D

@export var scroll: bool
@export var speed: float

func _process(delta):
	if scroll:
		self.position += Vector2(speed, 0)

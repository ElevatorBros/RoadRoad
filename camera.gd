extends Camera2D

@export var scroll: bool

func _process(delta):
	if scroll:
		self.position += Vector2(1, 0)

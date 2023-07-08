extends Camera2D

var current_target = Vector2(0,0)

var speed = 5

var percent_there = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("zoom_in"):
		self.zoom -= Vector2(0.1, 0.1)
	if Input.is_action_just_released("zoom_out"):
		self.zoom += Vector2(0.1, 0.1)
		
	if percent_there < 1:
		percent_there += delta * speed
	self.position = lerp(self.position, current_target, percent_there)

func on_update_camera_target(loc: Vector2):
	current_target = loc
	percent_there = 0

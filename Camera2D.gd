extends Camera2D

var current_target = Vector2(0,0)

var speed = 5

var percent_there = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if percent_there < 1:
		percent_there += delta * speed
	self.position = lerp(self.position, current_target, percent_there)

func on_update_camera_target(loc: Vector2):
	current_target = loc
	percent_there = 0

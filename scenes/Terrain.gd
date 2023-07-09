extends Node2D

var type = 0

var launching = false

func get_type() -> int:
	return type


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if randi() % 8 == 0:
		type = 1
	elif randi() % 4 == 0:
		type = 2
	else: 
		type = 0
	
	$AnimatedSprite2D.frame = type


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if launching:
		self.position += Vector2(5000 * delta,0)

func on_update_terrain_postion(loc: Vector2):
	self.global_position = loc

func launch():
	launching = true

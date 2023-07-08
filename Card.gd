extends Node2D

var current_target = Vector2(0,0)

var percent_there = 0

var speed = 10

var current_type = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = Vector2(100000,10000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if percent_there < 1:
		percent_there += delta * speed
	self.position = lerp(self.position, current_target, percent_there)

func on_set_current_target(loc: Vector2):
	percent_there = 0
	current_target = loc

func set_card_type(type: int):
	$AnimatedSprite2D.frame = type
	current_type = type

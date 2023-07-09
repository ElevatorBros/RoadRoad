extends Node2D

var current_target = Vector2(0,0)
var percent_there = 0
var speed = 1
var current_type = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	current_target = Vector2(0,0)
	percent_there = 0
	speed = 1
	self.position = Vector2(10000,10000)
	self.scale = Vector2(1.5,1.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameStarter.start_game:
		if percent_there < 1:
			percent_there += delta * speed
		# TODO: Ask josh about a better way to do this. 
		#self.position = lerp(self.position, current_target, percent_there / 2)
		#self.position.y += 100
		self.position = lerp(self.position, current_target, percent_there)

func on_set_current_target(loc: Vector2):
	percent_there = 0
	current_target = loc

func set_card_type(type: int):
	$AnimatedSprite2D.frame = type
	current_type = type

extends Node2D

var type = 0

var launching = false

func get_type() -> int:
	return type


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if randi() % 3 == 0: # Bomb
		type = 1
	elif randi() % 10 == 0: # Wrench
		type = 4
	elif randi() % 4 == 0: # Bannan
		type = 3
	elif randi() % 2 == 0: # Ice
		type = 2
	else: # Cone
		type = 0
	
	$AnimatedSprite2D.frame = type


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameStarter.start_game:
		if launching:
			self.position += Vector2(5000 * delta,0)

func on_update_terrain_postion(loc: Vector2):
	self.global_position = loc

func launch():
	launching = true

func hide_terrain():
	$AnimatedSprite2D.visible = false


func _on_terrain_area_entered(area):
	if area.get_name() == "Terrain":
		area.free()

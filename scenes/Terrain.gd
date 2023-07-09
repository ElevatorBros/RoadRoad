extends Node2D

var type = 0

func get_type() -> int:
	return type


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position.x = int(self.global_position.x)
	self.global_position.y = int(self.global_position.y)
	var camera = get_tree().root.get_child(0).get_child(0)
	if self.global_position.distance_to(camera.global_position) > 10000:
		#self.free()
		pass

func on_update_terrain_postion(loc: Vector2):
	self.global_position = loc
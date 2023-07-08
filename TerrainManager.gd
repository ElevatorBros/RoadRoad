extends CollisionShape2D

@export var terrain_scene: PackedScene

var chance = 100
var radius_x = 800
var radius_y = 3000

# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position = Vector2(5000, 0)

func spawn_terrain():
	var spawn_area = self.global_position
	
	var terrain = terrain_scene.instantiate()
	
	var x = randf_range(spawn_area.x - radius_x, spawn_area.x + radius_x)
	var y = randf_range(spawn_area.y - radius_y, spawn_area.y  + radius_y)
	
	terrain.global_position = Vector2(x, y)
	
	var scale = randf_range(0.3, 1.3)
	terrain.scale = Vector2(scale, scale)
		
	get_tree().get_root().add_child(terrain)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (randi() % chance == 0):
		spawn_terrain()

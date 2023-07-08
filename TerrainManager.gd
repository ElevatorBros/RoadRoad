extends Area2D

@export var terrain_scene: PackedScene

var chance = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_terrain():
	var spawn_area = $CollisionShape2D.shape.extents
	var origin = $CollisionShape2D.global_position - spawn_area
	var terrain = terrain_scene.instantiate()
	
	var x = randf_range(origin.x, spawn_area.x)
	var y = randf_range(origin.y, spawn_area.y)
	
	terrain.position = Vector2(x, y)
	
	var scale = randf_range(0.3, 1.3)
	terrain.scale = Vector2(scale, scale)
		
	get_tree().get_root().add_child(terrain)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (randi() % chance == 0):
		spawn_terrain()

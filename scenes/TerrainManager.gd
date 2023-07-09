extends Node2D

var grid_size = 96

var spawn_corner = Vector2(10,0)

var spawn_corner_offset = Vector2(6,-10)
var spawn_size = Vector2(10,40)

var fudge = Vector2(0,0)

@export var terrain_scene: PackedScene

signal update_terrain_position(loc: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	grid_size = 96
	spawn_corner = Vector2(10,0)
	spawn_corner_offset = Vector2(6,-10)
	spawn_size = Vector2(10,40)
	fudge = Vector2(0,0)

	randomize()
	for i in range(30):
		spawn_block()

func spawn_block():
	var x = randi() % int(spawn_size.x)
	var y = randi() % int(spawn_size.y)
	var place_loc = Vector2(spawn_corner.x + spawn_corner_offset.x + x, spawn_corner.y + spawn_corner_offset.y + y) * grid_size + fudge
	var terrain = terrain_scene.instantiate()
	update_terrain_position.connect(terrain.on_update_terrain_postion)
	update_terrain_position.emit(place_loc)
	update_terrain_position.disconnect(terrain.on_update_terrain_postion)
	add_child(terrain)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if GameStarter.start_game:
		var i = int(self.get_parent().find_child("Camera2D").global_position.x / grid_size)
		var j = int(self.get_parent().find_child("Camera2D").global_position.y / grid_size)
		spawn_corner = Vector2(i, j) + spawn_corner_offset
		for x in range(15):
			spawn_block()

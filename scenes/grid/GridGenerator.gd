extends Node2D

@onready var grid = load("res://scenes/grid/Grid.tres")
@export var grid_cell: PackedScene
var offset = Vector2(-20,-50)
var size = 96

# Called when the node enters the scene tree for the first time.
func _ready():
	offset = Vector2(-20,-50)
	generate_grid(Vector2(50,100))
	offset = Vector2(30,-50)
	generate_grid(Vector2(20,100))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera = get_parent().find_child("Camera2D")
	if (camera.custom_pos / size).distance_to(offset+Vector2(20,0)) < 100:
		offset += Vector2(20,0)
		generate_grid(Vector2(20,100))


func generate_grid(dimensions: Vector2):
	for y in dimensions.y:
		for x in dimensions.x:
			var position = grid.calculate_map_position(Vector2(x, y))
			var cell = grid_cell.instantiate()
			cell.find_child("AnimatedSprite2D").frame = int(x + int(y) % 2) % 2
			cell.global_position = position + (offset * size)
			add_child(cell)

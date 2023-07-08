extends Node2D

@export var straight_road_scene: PackedScene
@onready var straight_road = straight_road_scene.instantiate()
@onready var roads = find_child("Roads")

# Called when the node enters the scene tree for the first time.
func _ready():
	straight_road.global_position = Vector2(600,600)
	roads.add_child(straight_road)
	roads.move_child(straight_road, -1)


var last_mouse_position = Vector2(600, 600 + 125)

func add_road():
	var mouse = get_global_mouse_position()
	
	var scale = last_mouse_position.distance_to(mouse) / 125
	
	var new_straight_road = straight_road_scene.instantiate()
	
	new_straight_road.scale = Vector2(scale, 1)
	print("Mouse: ", mouse)
	print("Last: ", last_mouse_position)
	print("Distance:" , last_mouse_position.distance_to(mouse))
	print("Scale: ", new_straight_road.scale)
	
	new_straight_road.global_position = mouse
	new_straight_road.rotation = atan2(last_mouse_position.y - mouse.y, last_mouse_position.x - mouse.x)

	roads.add_child(new_straight_road)
	roads.move_child(new_straight_road, -1)
	
	last_mouse_position = mouse

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			add_road()

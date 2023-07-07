extends Node2D

@export var straight_road_scene: PackedScene
@onready var straight_road = straight_road_scene.instantiate()
@onready var roads = find_child("Roads")

# Called when the node enters the scene tree for the first time.
func _ready():
	straight_road.position = Vector2(600,600)
	roads.add_child(straight_road)
	roads.move_child(straight_road, -1)


func add_road():
	var mouse = get_global_mouse_position()
	var last_position = roads.get_child(-1).position
	var scale_x = max(mouse.x, last_position.x) / min(mouse.x, last_position.x)
	var new_straight_road = straight_road_scene.instantiate()
	
	new_straight_road.scale = Vector2(scale_x, 1)
	new_straight_road.position = mouse
	new_straight_road.rotation = atan2(last_position.y - mouse.y, last_position.x - mouse.x)
	print("Rotation: ", new_straight_road.rotation)

	roads.add_child(new_straight_road)
	roads.move_child(new_straight_road, -1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			add_road()

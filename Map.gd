extends Node2D

@export var straight_road_scene: PackedScene
@onready var straight_road = straight_road_scene.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	straight_road.position = Vector2(600,600)
	add_child(straight_road)
	move_child(straight_road, 0)
	

func add_road():
	var mouse = get_global_mouse_position()
	var last_position = get_child(0).position
	var scale_x = max(mouse.x, last_position.x) / min(mouse.x, last_position.x)
	var new_straight_road = straight_road_scene.instantiate()
	new_straight_road.scale = Vector2(scale_x, 1)
	new_straight_road.position = mouse
	new_straight_road.rotation = atan2(last_position.y - mouse.y, last_position.x - mouse.x)
	add_child(new_straight_road)
	move_child(new_straight_road, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		add_road()

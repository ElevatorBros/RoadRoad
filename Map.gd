extends Node2D

@export var straight_road_scene: PackedScene
#@onready var straight_road = straight_road_scene.instantiate()
#@onready var roads = find_child("Roads")
signal send_points_to_road(a: Vector2, b: Vector2, old_rot: float)

var old_mouse_pos = Vector2(-100,0)
var old_road_rot = 0

var counter = -50

func add_road(a, b, rot) -> float:
	var straight_road = straight_road_scene.instantiate()
	add_child(straight_road)
	move_child(straight_road, 0)
	send_points_to_road.connect(straight_road.on_send_points_to_road)
	send_points_to_road.emit(a, b, rot)
	send_points_to_road.disconnect(straight_road.on_send_points_to_road)
	
	return rot	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#straight_road.global_position = Vector2(600,600)
	#roads.add_child(straight_road)
	#roads.move_child(straight_road, -1)
	add_road(old_mouse_pos, old_mouse_pos + Vector2(500, 0), 0)
	old_mouse_pos += Vector2(500, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += 1
	if counter > 2:
		add_road(old_mouse_pos, Vector2($Camera2D.position.x, get_global_mouse_position().y), old_road_rot)
		old_mouse_pos = Vector2($Camera2D.position.x, get_global_mouse_position().y)
		counter = 0

func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
#			add_road(old_mouse_pos, get_global_mouse_position())
#			old_mouse_pos = get_global_mouse_position()
	#var current_mouse_pos = get_global_mouse_position()
	#if current_mouse_pos.distance_to(old_mouse_pos) > 50:
	#	add_road(old_mouse_pos, current_mouse_pos, old_road_rot)
	#	old_mouse_pos = get_global_mouse_position()
	pass

func _on_spawn_road_timeout():
	pass
#	add_road(old_mouse_pos, Vector2($Camera2D.position.x, get_global_mouse_position().y), old_road_rot)
#	old_mouse_pos = Vector2($Camera2D.position.x, get_global_mouse_position().y)

func on_update_old_rot(rot: float):
	old_road_rot = rot

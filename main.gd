extends Node2D

@export var straight_road: PackedScene
@export var up_road: PackedScene
@export var down_road: PackedScene

@export var moon_road: PackedScene

var current_marker_loc = Vector2(0,500)


signal send_point_to_road(loc: Vector2)

signal update_camera_target(loc: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_camera_target.connect($Camera2D.on_update_camera_target)
	current_marker_loc = $SpawnArea/SpawnShape.position + Vector2(50, 50)
	place_road(straight_road)
	$SpawnArea/SpawnShape.spawn_cars()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		place_road(straight_road)
	if Input.is_action_just_pressed("ui_up"):
		place_road(up_road)
	if Input.is_action_just_pressed("ui_down"):
		place_road(down_road)
	if Input.is_action_just_pressed("ui_left"):
		place_road(moon_road)

func place_road(road: PackedScene):
	var road_instance = road.instantiate()
	add_child(road_instance)
	move_child(road_instance, 0)
	
	send_point_to_road.connect(road_instance.on_send_point_to_road)
	send_point_to_road.emit(current_marker_loc)
	send_point_to_road.disconnect(road_instance.on_send_point_to_road)
	
	

func on_send_point_to_main(loc: Vector2):
	current_marker_loc = loc
	update_camera_target.emit(current_marker_loc)

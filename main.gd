extends Node2D

@export var straight_road: PackedScene
@export var slight_up_road: PackedScene
@export var slight_down_road: PackedScene
@export var very_up_road: PackedScene
@export var very_down_road: PackedScene

@export var car_scene: PackedScene

var road_mapping = []
var current_marker_loc = Vector2(0,500)
var last_road
var car


signal send_point_to_road(loc: Vector2)
signal send_car_to_road(car)
signal send_next_road_to_road(road)
signal update_camera_target(loc: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_camera_target.connect($Camera2D.on_update_camera_target)
	current_marker_loc = $SpawnArea/SpawnShape.position + Vector2(-100, -50)
	car = car_scene.instantiate()
	
	place_road(straight_road, true)
	
	#$SpawnArea/SpawnShape.spawn_cars()
	
	road_mapping.append(straight_road) 
	road_mapping.append(slight_up_road)
	road_mapping.append(slight_down_road)
	road_mapping.append(very_up_road)
	road_mapping.append(very_down_road)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameStarter.start_game:
		if Input.is_action_just_pressed("one"):
			place_road(road_mapping[$Camera2D/RoadOptionManager.use_card(0)], false)
		if Input.is_action_just_pressed("two"):
			place_road(road_mapping[$Camera2D/RoadOptionManager.use_card(1)], false)
		if Input.is_action_just_pressed("three"):
			place_road(road_mapping[$Camera2D/RoadOptionManager.use_card(2)], false)
		if Input.is_action_just_pressed("four"):
			place_road(road_mapping[$Camera2D/RoadOptionManager.use_card(3)], false)

func place_road(road: PackedScene, first_time: bool):
	var road_instance = road.instantiate()
	add_child(road_instance)
	move_child(road_instance, 0)
	
	
	if first_time:
		send_car_to_road.connect(road_instance.on_send_car_to_road)
		send_car_to_road.emit(car)
		send_car_to_road.disconnect(road_instance.on_send_car_to_road)
	
	if not first_time:
		send_next_road_to_road.connect(last_road.on_send_next_road_to_road)
		send_next_road_to_road.emit(road_instance)
		send_next_road_to_road.disconnect(last_road.on_send_next_road_to_road)

	
	send_point_to_road.connect(road_instance.on_send_point_to_road)
	send_point_to_road.emit(current_marker_loc)
	send_point_to_road.disconnect(road_instance.on_send_point_to_road)
	
	last_road = road_instance
	

func on_send_point_to_main(loc: Vector2):
	current_marker_loc = loc
	update_camera_target.emit(current_marker_loc)


func _on_place_road_timeout():
	place_road(straight_road, false)

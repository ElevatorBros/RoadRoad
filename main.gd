extends Node2D

@export var straight_road: PackedScene
@export var up_road: PackedScene

var current_marker_loc = Vector2(0,0)


signal send_point_to_road(loc: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func place_road(road: PackedScene):
	var road_instance = road.instantiate()
	add_child(road_instance)
	
	send_point_to_road.connect(road_instance.on_send_point_to_road)
	send_point_to_road.emit(current_marker_loc)
	send_point_to_road.disconnect(road_instance.on_send_point_to_road)
	
	

func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_1:
		place_road(straight_road)
	if ev is InputEventKey and ev.scancode == KEY_2:
		place_road(up_road)

func on_send_point_to_main(loc: Vector2):
	current_marker_loc = loc

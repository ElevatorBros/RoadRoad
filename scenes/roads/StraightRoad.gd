extends Node2D

var start_pos = Vector2(0,0)
var end_pos = Vector2(0,0)

var road_x_size = 680

var road_y_scale = 0.4

var indent = 20

func on_send_points_to_road(a: Vector2, b: Vector2):
	start_pos = a - Vector2(indent, 0)
	end_pos = b
	
	self.position = start_pos + ((end_pos - start_pos) / 2)
	
	self.rotation = atan2(end_pos.y - start_pos.y, end_pos.x - start_pos.x)
	
	#var distance = sqrt(pow(end_pos.y - start_pos.y,2) + pow(end_pos.x - start_pos.x,2))
	var distance = start_pos.distance_to(end_pos)
	self.scale = Vector2(distance/road_x_size, road_y_scale)

#
#func add_road():
#	var mouse = get_global_mouse_position()
#
#	var scale = last_mouse_position.distance_to(mouse) / 125
#
#	var new_straight_road = straight_road_scene.instantiate()
#
#	new_straight_road.scale = Vector2(scale, 1)
#	print("Mouse: ", mouse)
#	print("Last: ", last_mouse_position)
#	print("Distance:" , last_mouse_position.distance_to(mouse))
#	print("Scale: ", new_straight_road.scale)
#
#	new_straight_road.global_position = mouse
#	new_straight_road.rotation = atan2(last_mouse_position.y - mouse.y, last_mouse_position.x - mouse.x)
#
#	roads.add_child(new_straight_road)
#	roads.move_child(new_straight_road, -1)
#
#	last_mouse_position = mouse


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

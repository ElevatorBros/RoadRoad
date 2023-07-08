extends Node2D

var start_pos_top = Vector2(0.0,0.0)
var end_pos_top = Vector2(0.0,0.0)

var start_pos_bottom = Vector2(0.0,0.0)
var end_pos_bottom = Vector2(0.0,0.0)

var road_x_size = 3000.0

var road_y_scale = 1

var indent = 20

var separation = 300

signal update_old_rot(old_rot: float)

func on_send_points_to_road(a: Vector2, b: Vector2, old_rot: float):
	var rot = atan2(b.y - a.y, b.x - a.x)
	
	
	#old_rot = PI/2 - old_rot
	#start_pos_top = a - Vector2(sin(old_rot)*separation, cos(old_rot)*separation)
	#end_pos_top = b - Vector2(sin(rot)*separation, cos(rot)*separation)
	start_pos_top = a - Vector2(cos(old_rot + PI/2)*separation, sin(old_rot + PI/2)*separation)
	end_pos_top = b - Vector2(cos(rot + PI/2)*separation, sin(rot + PI/2)*separation)
	
	$StaticBody2D/Top.position = start_pos_top + ((end_pos_top - start_pos_top) / 2)
	$StaticBody2D/Top.rotation = atan2(end_pos_top.y - start_pos_top.y, end_pos_top.x - start_pos_top.x)
	$StaticBody2D/Top.scale = Vector2(start_pos_top.distance_to(end_pos_top)/road_x_size, road_y_scale)
	
	start_pos_bottom = a + Vector2(cos(old_rot + PI/2)*separation, sin(old_rot + PI/2)*separation)
	end_pos_bottom = b + Vector2(cos(rot + PI/2)*separation, sin(rot + PI/2)*separation)
	
	$StaticBody2D/Bottom.position = start_pos_bottom + ((end_pos_bottom - start_pos_bottom) / 2)
	$StaticBody2D/Bottom.rotation = atan2(end_pos_bottom.y - start_pos_bottom.y, end_pos_bottom.x - start_pos_bottom.x)
	$StaticBody2D/Bottom.scale = Vector2(start_pos_bottom.distance_to(end_pos_bottom)/road_x_size, road_y_scale)

	
#	self.position = start_pos + ((end_pos - start_pos) / 2)
#	self.rotation = atan2(end_pos.y - start_pos.y, end_pos.x - start_pos.x)
#
#	#var distance = sqrt(pow(end_pos.y - start_pos.y,2) + pow(end_pos.x - start_pos.x,2))
#	var distance = start_pos.distance_to(end_pos)
#	self.scale = Vector2(distance/road_x_size, road_y_scale)

	var root_node = get_tree().get_root().get_node("Map") 

	update_old_rot.connect(root_node.on_update_old_rot)
	update_old_rot.emit(rot)
	update_old_rot.disconnect(root_node.on_update_old_rot)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

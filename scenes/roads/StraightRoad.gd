extends Node2D

var start_pos_top = Vector2(0,0)
var end_pos_top = Vector2(0,0)

var start_pos_bottom = Vector2(0,0)
var end_pos_bottom = Vector2(0,0)

var road_x_size = 680

var road_y_scale = 0.4

var indent = 20

func on_send_points_to_road(a: Vector2, b: Vector2, old_rot: float):
	start_pos_top = a + Vector2(0, -50)
	end_pos_top = b + Vector2(0, -50)
	
	$StaticBody2D/Top.position = start_pos_top + ((end_pos_top - start_pos_top) / 2)
	$StaticBody2D/Top.rotation = atan2(end_pos_top.y - start_pos_top.y, end_pos_top.x - start_pos_top.x)
	$StaticBody2D/Top.scale = Vector2(start_pos_top.distance_to(end_pos_top)/road_x_size, road_y_scale)
	
	start_pos_bottom = a + Vector2(0, 50)
	end_pos_bottom = b + Vector2(0, 50)
	
	$StaticBody2D/Bottom.position = start_pos_bottom + ((end_pos_bottom - start_pos_bottom) / 2)
	$StaticBody2D/Bottom.rotation = atan2(end_pos_bottom.y - start_pos_bottom.y, end_pos_bottom.x - start_pos_bottom.x)
	$StaticBody2D/Bottom.scale = Vector2(start_pos_bottom.distance_to(end_pos_bottom)/road_x_size, road_y_scale)
	
#	self.position = start_pos + ((end_pos - start_pos) / 2)
#	self.rotation = atan2(end_pos.y - start_pos.y, end_pos.x - start_pos.x)
#
#	#var distance = sqrt(pow(end_pos.y - start_pos.y,2) + pow(end_pos.x - start_pos.x,2))
#	var distance = start_pos.distance_to(end_pos)
#	self.scale = Vector2(distance/road_x_size, road_y_scale)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Node2D

signal send_point_to_main(loc: Vector2)

var has_car = false
var car_inst

var has_next_road = false
var next_road_inst

signal send_car_to_road(car)

# Called when the node enters the scene tree for the first time.
func _ready():
	has_car = false
	has_next_road = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#self.global_position.x = int(self.global_position.x)
	#self.global_position.y = int(self.global_position.y)
	#var camera = get_tree().root.get_child(0).get_child(0)
	#if self.global_position.distance_to(camera.global_position) > 10000:
		#self.free()
	#	pass
	
	if GameStarter.start_game:
		if has_car and not Car.has_died:
			if $Path2D/PathFollow2D.progress_ratio >= 0.95:
				if has_next_road:
					$Path2D/PathFollow2D.remove_child(car_inst)
					send_car_to_road.connect(next_road_inst.on_send_car_to_road)
					send_car_to_road.emit(car_inst)
					send_car_to_road.disconnect(next_road_inst.on_send_car_to_road)
					has_car = false
				else:
					#print("end of road")
					if not Car.is_zen:
						car_inst.death()
					
			
			else:	
				var speed = car_inst.get_speed()
				$Path2D/PathFollow2D.progress += speed * delta
			


func on_send_point_to_road(loc: Vector2):
	#var start_loc = $Beginning.position
	var start_loc = $Beginning.global_position
	self.position = loc - start_loc
	#self.global_position = loc - start_loc + Vector2(1,1)
	
	var root_node = get_tree().get_root().get_node("Main") 

	send_point_to_main.connect(root_node.on_send_point_to_main)
	send_point_to_main.emit(self.position + $End.position)
	send_point_to_main.disconnect(root_node.on_send_point_to_main)

func on_send_car_to_road(car):
	car_inst = car
	has_car = true
	$Path2D/PathFollow2D.add_child(car_inst)
	$Path2D/PathFollow2D.progress = 0

func on_send_next_road_to_road(road):
	next_road_inst = road
	has_next_road = true

extends Camera2D

@export var goal_scene: PackedScene

var current_target = Vector2(0,0)

var speed = 5

var percent_there = 0

var custom_pos = Vector2(0,0)

var zoom_out = false
var zoom_start = 12
var zoom_goal = 2
var zoom_percent = 0

var start_wait = 1


func _ready():
	current_target = Vector2(0,0)
	speed = 5

	percent_there = 0

	custom_pos = Vector2(0,0)

	zoom_out = false
	zoom_start = 12
	zoom_goal = 2
	zoom_percent = 0
	start_wait = 1

	self.set_zoom(Vector2(zoom_start,zoom_start))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_wait > 0:
		start_wait -= delta
	elif GameStarter.start_game:
		#if Input.is_action_just_released("zoom_in"):
		#	self.zoom -= Vector2(0.1, 0.1)
		#if Input.is_action_just_released("zoom_out"):
		#	self.zoom += Vector2(0.1, 0.1)
			
		#if percent_there < 1:
		#	percent_there += delta * speed
		#self.position = lerp(self.position, current_target, percent_there)
		
		#custom_pos = self.position
		pass
		
	else:
		if Input.is_action_just_pressed("ui_accept"):
			self.get_parent().find_child("Title").visible = false
			zoom_out = true
			if Car.current_mode == 0:
				Car.goal = Car.race_distances[Car.current_var]
				
				for i in range(50):
					var end_line = goal_scene.instantiate()
					end_line.global_position = Vector2(96 * Car.goal, (-50 * 96) + 96 * i * 2)
					get_tree().root.get_child(0).add_child(end_line)
			elif Car.current_mode == 1:
				Car.time_to_win = Car.race_times[Car.current_var]
				Car.is_timed = true
			else:
				if Car.current_var == 1:
					Car.speed = 300
				elif Car.current_var == 2:
					Car.is_zen = true
					Car.speed = 150
		
		if zoom_out:
			var zoom = lerp(zoom_start, zoom_goal, zoom_percent)
			self.set_zoom(Vector2(zoom,zoom))
			zoom_percent += 0.6 * delta
			if zoom_percent > 1.0:
				zoom_out = false
				GameStarter.start_game = true
				
		self.global_position = Car.global_position

func on_update_camera_target(loc: Vector2):
	self.global_position = loc

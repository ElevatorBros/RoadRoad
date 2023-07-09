extends Camera2D

var current_target = Vector2(0,0)

var speed = 5

var percent_there = 0

var custom_pos = Vector2(0,0)

var zoom_out = false
var zoom_start = 12
var zoom_goal = 2
var zoom_percent = 0


func _ready():
	if OS.is_debug_build():
		# TODO: Discuss with Josh and Orestes to see if this is cool
		#self.set_zoom(Vector2(0.5,0.5))
		#self.set_zoom(Vector2(2,2))
		self.set_zoom(Vector2(zoom_start,zoom_start))
		#self.global_position += Vector2(0,-75)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameStarter.start_game:
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
		if Input.is_action_just_released("ui_accept"):
			self.get_parent().find_child("Title").visible = false
			zoom_out = true
		
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

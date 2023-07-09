extends CharacterBody2D

var speed = 50
var initial_velocity = Vector2(speed, 0)
var min_velocity = Vector2(-1 * speed, -1 * speed)
var max_velocity = Vector2(speed, speed)

func _ready():
	randomize()
	set_velocity(initial_velocity)
	
func _process(delta):
	var camera = get_tree().root.get_child(0).get_child(0)
	if self.global_position.distance_to(camera.global_position) > 10000:
		#self.free()

var hit = Vector2(0, 0)
func _draw():
	draw_line(global_position, global_position + Vector2(100,0), Color(1, 0, 0))
	
func _physics_process(delta):
	find_child("Sprite2D").rotation = velocity.angle()
	
	if velocity == Vector2.ZERO:
		velocity = initial_velocity.normalized()
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	#var mouse = get_global_mouse_position()
	#var mouse = get_tree().get_root().get_node("Main").get_child("Camera").position
	
	var bias = 100 * delta
	#var pos_diff = (mouse - global_position).normalized()
	# add a bit of random
	var pos_diff = Vector2(10 + (0.5-(randi() % 100)/100),(0.5-(randi() % 100)/100))

	velocity += pos_diff * bias
	velocity = velocity.clamp(min_velocity, max_velocity)
	
	
	var space_state = get_world_2d().direct_space_state
	
	
	var left_ray = PhysicsRayQueryParameters2D.create(
		global_position, global_position + Vector2(0, -20))
	
	var right_ray = PhysicsRayQueryParameters2D.create(
		global_position, global_position + Vector2(0, 20))
	
	var front_ray = PhysicsRayQueryParameters2D.create(
		global_position, global_position + Vector2(20, 0))
		
	var result_left = space_state.intersect_ray(left_ray)
	var result_right = space_state.intersect_ray(right_ray)
	var result_front = space_state.intersect_ray(front_ray)
	
	if result_left:
		#print("Left: ", result_left.position)
		pass
		
	if result_right:
		#print("Right: ", result_right.position)
		velocity += Vector2(0, -20)
	
	if result_front:
		velocity += Vector2(-20, 0)
	
	queue_redraw()


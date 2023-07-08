extends CharacterBody2D

var initial_velocity = Vector2(500, 0)
var min_velocity = Vector2(-800, -800)
var max_velocity = Vector2(800, 800)

func _ready():
	randomize()
	set_velocity(initial_velocity)
	
func _process(delta):
	var camera = get_tree().root.get_child(0).get_child(0)
	if self.global_position.distance_to(camera.global_position) > 10000:
		self.free()

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

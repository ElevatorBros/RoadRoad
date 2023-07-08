extends CharacterBody2D

var initial_velocity = Vector2(300, 300)
var min_velocity = Vector2(-800, -800)
var max_velocity = Vector2(800, 800)

func _ready():
	set_velocity(initial_velocity)

func _physics_process(delta):
	rotation = velocity.angle()
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	var mouse = get_global_mouse_position()
	
	var bias = 300 * delta
	var pos_diff = (mouse - global_position).normalized()

	velocity += pos_diff * bias
	velocity = velocity.clamp(min_velocity, max_velocity)
		

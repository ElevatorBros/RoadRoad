extends CharacterBody2D

var initial_velocity = Vector2(250, 10)

func _ready():
	set_velocity(initial_velocity)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	rotation = velocity.angle()
	
	var mouse = get_global_mouse_position()
	
	var bias = 1000 * delta
	var pos_diff = (mouse - position).normalized()
	
	velocity += pos_diff * bias
		

extends Node2D

var has_died = false

var normal_speed = 350
var speed = normal_speed

var start_slow_down = false
var start_speeding_up = false
var slow_down_percent = 1

func get_speed() -> int:
	return speed

# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimatedSprite2D.visible = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_slow_down:
		if slow_down_percent > 0.5:
			slow_down_percent -= 0.5 * delta
		else:
			start_slow_down = false
	elif start_speeding_up:
		if slow_down_percent < 1:
			slow_down_percent += 0.5 * delta
		else:
			start_speeding_up = false
			
	speed = normal_speed * slow_down_percent

func death():
	if not has_died:
		has_died = true
		Car.has_died = true
		$Sprite2D.visible = false
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play()


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.visible = false

func slow_down():
	start_slow_down = true
	$SlowDown.start()
	
func speed_up():
	pass

func _on_area_2d_area_entered(area):
	if area.get_name() == "Terrain":
		var type = area.get_parent().get_type()
		if type == 0: # cone
			slow_down()
			area.get_parent().launch()
		elif type == 2: # speed
			speed_up()
		else:
			death()


func _on_slow_down_timeout():
	start_speeding_up = true

extends Node2D

var has_died = false

var normal_speed = 200
var speed = normal_speed

var start_slow_down = false
var start_speeding_up = false
var slow_down_percent = 1

var speeding_up_start = false
var speeding_down_start = false
var speed_up_percent = 1

var spinning = false

var spin_deck = false

var has_gold = false

var current_car_type = "Small"
var current_car_var = 0

func get_speed() -> int:
	return speed

# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimatedSprite2D.visible = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameStarter.start_game:
		if spinning:
			self.rotate(15 * delta)
		if start_slow_down:
			if slow_down_percent > 0.75:
				slow_down_percent -= 0.5 * delta
			else:
				start_slow_down = false
		elif start_speeding_up:
			if slow_down_percent < 1:
				slow_down_percent += 0.5 * delta
			else:
				start_speeding_up = false
		elif speeding_up_start:		
			if speed_up_percent < 1.8:
				speed_up_percent += 2 * delta
			else:
				speeding_up_start = false
		elif speeding_down_start:
			if speed_up_percent > 1:
				speed_up_percent -= 0.5 * delta
			else:
				speeding_down_start = false
				
		speed = normal_speed * slow_down_percent * speed_up_percent

func death():
	if not has_died:
		has_died = true
		Car.has_died = true
		self.find_child(current_car_type).visible = false
		$Explosion.global_rotation = 0
		$Explosion.visible = true
		$Explosion.play()


func _on_animated_sprite_2d_animation_finished():
	$Explosion.visible = false

func slow_down():
	start_slow_down = true
	$SlowDown.start()
	
func speed_up():
	speeding_up_start = true
	$SlowDown.start()
	
func spin():
	spinning = true
	$Spin.start()
	Car.spin_deck = true

func add_gold():
	has_gold = true
	self.find_child(current_car_type).frame = 3
	
func remove_gold():
	has_gold = false
	$Explosion.global_rotation = 0
	$Explosion.visible = true
	$Explosion.play()
	self.find_child(current_car_type).frame = current_car_var

func _on_area_2d_area_entered(area):
	if area.get_name() == "Terrain":
		var type = area.get_parent().get_type()
		if type == 0: # cone
			slow_down()
			area.get_parent().launch()
		elif type == 2: # Ice
			speed_up()
		elif type == 3: # bannan
			spin()
		elif type == 4: # Wrench
			add_gold()
		else:
			if has_gold:
				remove_gold()
			else:
				death()


func _on_slow_down_timeout():
	start_speeding_up = true
	speeding_down_start = true

func _on_spin_timeout():
	spinning = false
	self.rotation = 0

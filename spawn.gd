extends CollisionShape2D

@export var spawn: bool
@export var car_amount: int
@export var car_scene: PackedScene

func _ready():
	if spawn:
		var spawn_area = self.shape.extents
		var origin = self.global_position -  spawn_area
		
		for i in car_amount:
			var car = car_scene.instantiate()
			
			var x = randf_range(origin.x, spawn_area.x)
			var y = randf_range(origin.y, spawn_area.y)
			
			car.global_position = Vector2(x, y)
			car.scale = Vector2(0.3, 0.3)
			
			add_child(car)

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var camera = get_tree().root.get_child(0).get_child(0)
	if self.global_position.distance_to(camera.global_position) > 10000:
		self.free()


func _on_area_2d_body_entered(body):
	body.free()
	pass # Replace with function body.
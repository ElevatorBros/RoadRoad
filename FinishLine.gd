extends Node2D

func _on_area_2d_area_entered(area):
	if area.get_name() == "Area2DCar":
		Car.win()

func on_self_delete():
	self.queue_free()

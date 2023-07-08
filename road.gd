extends Node2D

signal send_point_to_main(loc: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_send_point_to_road(loc: Vector2):
	var start_loc = $Beginning.position
	self.position = loc - start_loc
	
	var root_node = get_tree().get_root().get_node("Main") 

	send_point_to_main.connect(root_node.on_send_point_to_main)
	send_point_to_main.emit(self.position + $End.position)
	send_point_to_main.disconnect(root_node.on_send_point_to_main)
	

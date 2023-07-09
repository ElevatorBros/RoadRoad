extends Node2D

var has_died = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func death():
	if not has_died:
		has_died = true
		$Sprite2D.visible = false
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play()


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.visible = false


func _on_area_2d_area_entered(area):
	if area.get_name() == "Terrain":
		death()

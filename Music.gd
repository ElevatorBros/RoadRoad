extends Node2D

var fade_out_title_var = false

var main_is_playing = false

var mute = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fade_out_title_var:
		if $TitleSong.volume_db > -40:
			$TitleSong.volume_db -= 20 * delta
		else:
			$TitleSong.stop()
			fade_out_title_var = false

	if Input.is_action_just_pressed("m"):
		mute_toggle()

func play_title():
	$TitleSong.play()
	
func fade_out_title():
	fade_out_title_var = true
	
func play_main():
	if not main_is_playing:
		$MainSong.play()
		main_is_playing = true
		
func mute_toggle():
	if mute:
		mute = false
		$MainSong.volume_db = -10.0
		$TitleSong.volume_db = -10.0
	else:
		mute = true
		$MainSong.volume_db = -100
		$TitleSong.volume_db = -100

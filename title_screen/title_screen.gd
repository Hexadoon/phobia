extends Control

# Handles fade out of background music
onready var tween_out = $"Background Music/Tween"
export var transition_duration = 1
export var transition_type = 1

# Keeps track of which button was pressed
var scene

func _on_Quit_Button_pressed():
	scene = "Quit"
	fade_out_music()
	$"Fade In".show()
	$"Fade In".fade_in()

func _on_New_Game_Button_pressed():
	scene = "New Game"
	fade_out_music()
	$"Fade In".show()
	$"Fade In".fade_in()

func _on_Fade_In_fade_finished():
	if scene == "Quit":
		get_tree().quit()
	elif scene == "New Game":
		get_tree().change_scene("res://game/World.tscn")
	else:
		pass

func _on_AudioStreamPlayer2D_finished():
	var background_music = $"Background Music/AudioStreamPlayer2D"
	background_music.play()
	
func fade_out_music():
	"""
	Fades out background music on scene change.
	"""
	var background_music = $"Background Music/AudioStreamPlayer2D"
	tween_out.interpolate_property(background_music, "volume_db", -12.5, -80, 
	transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()

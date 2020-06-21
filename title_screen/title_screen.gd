extends Control

var scene_path_to_load

# Handles fade out of background music
onready var tween_out = $"Background Music/Tween"
export var transition_duration = 1
export var transition_type = 1

func _ready():
	"""
	Connects scene to load with their respective buttons and 
	sets up keyboard functionality to select a button.
	"""
	$"Menu/Center Row/Buttons/New Game Button".grab_focus()
	for button in $"Menu/Center Row/Buttons".get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	"""
	Begins Fade In animation.
	"""
	scene_path_to_load = scene_to_load
	
	fade_out_music()
	$"Fade In".show()
	$"Fade In".fade_in()

func _on_Fade_In_fade_finished():
	"""
	Switches scenes upon completion of Fade In animation.
	If Quit is selected, game is exitted.
	"""
	if scene_path_to_load == "res://game/Quit.tscn":
		get_tree().quit()
	else:
		get_tree().change_scene(scene_path_to_load)


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
	

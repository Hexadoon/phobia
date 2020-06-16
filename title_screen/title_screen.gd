extends Control

var scene_path_to_load

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

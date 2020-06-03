extends Control

var scene_path_to_load

func _ready():
	"""
	Connects scene to load with their respective buttons and 
	sets up keyboard functionality to select a button.
	"""
	$"CenterContainer/VBoxContainer/Resume Button".grab_focus()
	for button in $"CenterContainer/VBoxContainer".get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	"""
	Begins Fade In animation.
	"""
	scene_path_to_load = scene_to_load
	get_tree().paused = not get_tree().paused
	get_tree().change_scene(scene_path_to_load)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$"CenterContainer/VBoxContainer/Resume Button".grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible


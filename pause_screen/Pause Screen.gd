extends Control

# Reveals pause screen when "escape" is pressed
# Pauses the game
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$"CenterContainer/VBoxContainer/Resume Button".grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible

# Unpauses game and hides pause screen
func _on_Resume_Button_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible

# Unpauses game and changes scene to controls scene
func _on_Controls_Button_pressed():
	get_tree().paused = not get_tree().paused
	get_tree().change_scene("res://game/Controls (Pause Screen).tscn")

# Unpauses game and changes scene to main menu scene
func _on_Exit_To_Menu_Button_pressed():
	get_tree().paused = not get_tree().paused
	get_tree().change_scene("res://title_screen/Title Screen.tscn")

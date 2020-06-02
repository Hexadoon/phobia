extends Control


func _on_Button_pressed():
	"""
	Changes scene back to Title Screen.
	"""
	get_tree().change_scene("res://title_screen/Title Screen.tscn")

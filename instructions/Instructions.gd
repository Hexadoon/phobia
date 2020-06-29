extends Node2D

func _ready():
	$"ColorRect/Button".grab_focus()

func _on_Button_pressed():
	visible = not visible

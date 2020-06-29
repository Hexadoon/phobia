extends Control

var pause_screen

func _ready():
	pause_screen = get_parent().get_parent().get_node("CanvasLayer/Pause Screen")

func _on_Back_Button_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible
	pause_screen.visible = not visible

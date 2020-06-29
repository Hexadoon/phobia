extends Control

var pause_screen

func _ready():
	pause_screen = get_parent().get_parent().get_node("CanvasLayer/Pause Screen")

func _physics_process(delta):
	if visible:
		$"ColorRect/Back Button".grab_focus()

func _on_Back_Button_pressed():
	visible = not visible
	pause_screen.visible = not visible

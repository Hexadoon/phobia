extends Area2D

var hold = false
var canpickup = false

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_pickup") and canpickup == true:
		if hold == false:
			hold = true
			visible = not visible

func _on_Key_area_entered(area):
	if hold == false:
		canpickup = true

func _on_Key_area_exited(area):
	if hold == false:
		canpickup = false

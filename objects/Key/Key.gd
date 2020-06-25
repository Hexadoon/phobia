extends Area2D

var hold = false
var canpickup = false

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_pickup") and canpickup == true:
		if hold == true:
			pass
		else:
			print("player picked up key")
			hold = true
			visible = not visible

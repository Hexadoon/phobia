extends Area2D

var hold = false
var canpickup = false

onready var player_vars = get_node("/root/PlayerVariables")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_pickup") and canpickup == true:
		if hold == false:
			hold = true
			visible = not visible

func _on_Key_area_entered(area):
	if hold == false and player_vars.FLAG:
		canpickup = true

func _on_Key_area_exited(area):
	if hold == false:
		canpickup = false

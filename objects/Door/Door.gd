extends Area2D

var cango = false
var delay = 0

export(String, FILE, "*.tscn") var world_scene

func _physics_process(delta):
	if delay == 0:
		if Input.is_action_just_pressed("ui_accept") and cango == true:
			delay = 1
		else:
			$AnimatedSprite.play("door_close")
	elif delay < 70:
		$AnimatedSprite.play("door_open")
		delay += 1
	else:
		get_tree().change_scene(world_scene)
	
func _on_Door_area_entered(area):
	cango = true

func _on_Door_area_exited(area):
	cango = false

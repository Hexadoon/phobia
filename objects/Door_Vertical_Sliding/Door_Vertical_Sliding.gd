extends Area2D

var open = false
var in_motion = false
var in_range = false

export(String, FILE, "*.tscn") var world_scene

func _physics_process(delta):
	"""
	Controls state of door.
	"""
	if in_motion == false:
		if Input.is_action_just_pressed("ui_accept") and open == false and \
		in_range == true:
			open = true
			in_motion = true
			$AnimatedSprite.play("door_open")
		
		elif Input.is_action_just_pressed("ui_accept") and open == true and \
		in_range == true:
			open = false
			in_motion = true
			$AnimatedSprite.play("door_close")
		
		elif open == true:
			$AnimatedSprite.play("door_open_idle")
		
		else:
			$AnimatedSprite.play("door_close_idle")
	

func _on_AnimatedSprite_animation_finished():
	"""
	Handles completion of door open / close animations.
	"""
	if open == true:
		print("Door finished opening")
		$AnimatedSprite.play("door_open_idle")
		in_motion = false
	else:
		print("Door finished closing")
		$AnimatedSprite.play("door_close_idle")
		in_motion = false

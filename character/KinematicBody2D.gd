extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 200
const GRAVITY = 30
const JUMP_FORCE = -400

var motion = Vector2()

func _physics_process(delta):
	"""
	This function runs 60 times / second (every frame)
	Monitors game, checks to see if user presses button,
	controls movement.
	"""
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0
		
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		motion.y = JUMP_FORCE
			
	# Performs the motion (changes x,y coords of vector)
	motion = move_and_slide(motion, UP)
	
	
	
	

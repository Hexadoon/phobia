extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 200
const GRAVITY = 30
const JUMP_FORCE = -400

var motion = Vector2()
var idle_animation = "Idle" # Controls which idle animation is played.
var flag = true # Will allow for pick up animation to play in full.
var door

func _ready():
	door = get_parent().get_node("Door")

func _physics_process(delta):
	"""
	Constantly checks to see if user presses button, controls movement.
	@input: up / w: Jump
	@input: left / a: Move Left
	@input: right / d: Move Right
	@input: down / s: Crouch
	@input: z: Pick Up
	"""
	# On floor
	if is_on_floor():
		# Makes sure pickup animation is not currently happening.
		if flag:
			# Crouching
			if Input.is_action_pressed("ui_down"):
				# Transitions.
				if Input.is_action_just_pressed("ui_right"):
					$Sprite.flip_h = false
					$Sprite.play("Crouch_Transition")
					
				elif Input.is_action_just_pressed("ui_left"):
					$Sprite.flip_h = true
					$Sprite.play("Crouch_Transition")
				
				# Looping animations.
				if Input.is_action_pressed("ui_right"):
					motion.x = SPEED
					$Sprite.play("Crouch_Walk")
		
				elif Input.is_action_pressed("ui_left"):
					motion.x = -SPEED
					$Sprite.play("Crouch_Walk")
				
				else:
					motion.x = 0
					$Sprite.play("Crouch_Idle")
				
			# Standing
			else:
				# Transitions.
				if Input.is_action_just_pressed("ui_right"):
					$Sprite.flip_h = false
					$Sprite.play("Idle_to_Walk")
					
				elif Input.is_action_just_pressed("ui_left"):
					$Sprite.flip_h = true
					$Sprite.play("Idle_to_Walk")
					
				# Looping animations.
				if Input.is_action_pressed("ui_right"):
					motion.x = SPEED
					$Sprite.play("Walk")
		
				elif Input.is_action_pressed("ui_left"):
					motion.x = -SPEED
					$Sprite.play("Walk")
					
				elif Input.is_action_just_pressed("ui_pickup"):
					$Sprite.play("Pick_Up")
					flag = false
				
				else:
					motion.x = 0
					$Sprite.play(idle_animation)
	
			if Input.is_action_just_pressed("ui_up"):
				
				#TODO: Once ladders are added, check if player is in contact with a 
				# ladder to do climb animation instead of jump!
				
				$Sprite.play("Jump")
				motion.y = JUMP_FORCE
	# In air.
	else:
		if Input.is_action_pressed("ui_right"):
			motion.x = SPEED
			$Sprite.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
			$Sprite.flip_h = true

	# Handles gravity and applies motion.
	motion.y += GRAVITY
	motion = move_and_slide(motion, UP)
	
func _on_Sprite_animation_finished():
	"""
	Controls:
		- completion of pick up animation.
		- switching between idle and idle blinking animations.
	"""
	# Handles pick up
	if !flag:
		$Sprite.play(idle_animation)
		flag = true
	# Handles idle
	else:
		if idle_animation == "Idle":
			idle_animation = "Idle_Blinking"
		elif idle_animation == "Idle_Blinking":
			idle_animation = "Idle_Looking_Around"
		else:
			idle_animation = "Idle"

func _on_Door_area_entered(area):
	print("player collide with door")
	door.cango = true
	pass

func _on_Door_area_exited(area):
	print("player exit from door")
	door.cango = false
	pass

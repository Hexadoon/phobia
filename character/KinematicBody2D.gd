extends KinematicBody2D

# CONSTANT VARIABLES
const UP = Vector2(0, -1)
const SPEED = 500
const GRAVITY = 30
const JUMP_FORCE = -500

var motion = Vector2()

var count = 0
var idle_animation = "Idle" # Controls which idle animation is played.

var flag = true # Will allow for pick up animation to play in full.

var walking = false

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
					if !$AudioStreamPlayer2D.is_playing():
						walking = true
		
				elif Input.is_action_pressed("ui_left"):
					motion.x = -SPEED
					$Sprite.play("Crouch_Walk")
					if !$AudioStreamPlayer2D.is_playing():
						walking = true
				
				else:
					motion.x = 0
					$Sprite.play("Crouch_Idle")
					walking = false
				
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
					if !$AudioStreamPlayer2D.is_playing():
						walking = true
		
				elif Input.is_action_pressed("ui_left"):
					motion.x = -SPEED
					$Sprite.play("Walk")
					if !$AudioStreamPlayer2D.is_playing():
						walking = true
					
				elif Input.is_action_just_pressed("ui_pickup"):
					$Sprite.play("Pick_Up")
					flag = false
				
				else:
					motion.x = 0
					$Sprite.play(idle_animation)
					walking = false
	
			if Input.is_action_just_pressed("ui_up"):
				
				#TODO: Once ladders are added, check if player is in contact with a 
				# ladder to do climb animation instead of jump!
				motion.y = JUMP_FORCE
				$Sprite.play("Jump")
				
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
	sound()

func sound():
	if walking == true && !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.play()
	elif walking == false:
		$AudioStreamPlayer2D.stop()
	else:
		pass

func _on_Sprite_animation_finished():
	"""
	Controls:
		- completion of pick up animation.
		- switching between idle and idle blinking animations.
	"""
	# Handles pick up
	if !flag && (count < 6 || (count > 6 && count < 11) || (count > 11 && count < 15)):
		$Sprite.play(idle_animation)
		flag = true
		count += 1
	# Handles idle
	else:
		if (count == 6 || count == 15):
			idle_animation = "Idle_Blinking"
		elif count == 11:
			idle_animation = "Idle_Looking_Around"
		else:
			idle_animation = "Idle"
		count += 1
	if count == 16:
		count = 0

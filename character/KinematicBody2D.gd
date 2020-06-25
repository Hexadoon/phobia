extends KinematicBody2D

const UP = Vector2(0, -1)
const SPEED = 500 #200
const GRAVITY = 30
const JUMP_FORCE = -500

var motion = Vector2()
var idle_animation = "Idle" # Controls which idle animation is played.
var flag = true # Will allow for pick up animation to play in full.

var walking = false

var door
var door_locked
var door_horizontal_sliding
var door_vertical_sliding
var key

var count = 0

func _ready():
	door = get_parent().get_node("Door")
	door_locked = get_parent().get_node("Door_Locked")
	key = get_parent().get_node("Key")
	door_horizontal_sliding = get_parent().get_node("Door_Horizontal_Sliding")
	door_vertical_sliding = get_parent().get_node("Door_Vertical_Sliding")
	

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

# Handles character interaction with doors

func _on_Door_area_entered(area):
	print("player collide with door")
	door.cango = true
	pass

func _on_Door_area_exited(area):
	print("player exit from door")
	door.cango = false
	pass

func _on_Door_Locked_area_entered(area):
	print("player collide with door")
	if key.hold == true:
		door_locked.cango = true
	else:
		pass

func _on_Door_Locked_area_exited(area):
	print("player exit from door")
	door_locked.cango = false
	pass

func _on_Door_Horizontal_Sliding_area_entered(area):
	print("player collide with door")
	door_horizontal_sliding.in_range = true
	pass


func _on_Door_Horizontal_Sliding_area_exited(area):
	print("player exit from door")
	door_horizontal_sliding.in_range = false
	pass


func _on_Door_Vertical_Sliding_area_entered(area):
	print("player collide with door")
	door_vertical_sliding.in_range = true
	pass


func _on_Door_Vertical_Sliding_area_exited(area):
	print("player exit from door")
	door_vertical_sliding.in_range = false
	pass

func _on_Key_area_entered(area):
	if key.hold == true:
		pass
	else:
		print("player can pick up key")
		key.canpickup = true
		pass

func _on_Key_area_exited(area):
	if key.hold == true:
		pass
	else:
		print("player cannot pick up key")
		key.canpickup = false
		pass

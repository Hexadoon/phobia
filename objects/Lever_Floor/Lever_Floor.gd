extends Area2D

var left = true
var in_motion = false
var in_range = false

var lever_count
var on_screen_counter

export(String, FILE, "*.tscn") var world_scene

func _ready():
	lever_count = get_parent().get_parent().get_node("Win Condition/Area2D")
	on_screen_counter = get_parent().get_parent().get_node("On Screen Text/Counter")
	

func _physics_process(delta):
	"""
	Controls state of lever.
	"""
	if in_motion == false:
		if Input.is_action_just_pressed("ui_accept") and left == true and \
		in_range == true:
			left = false
			in_motion = true
			$AnimatedSprite.play("switch_left_to_right")
			
			lever_count.count += 1
			on_screen_counter.text = str(lever_count.count)
			$AudioStreamPlayer.play()
		
		elif Input.is_action_just_pressed("ui_accept") and left == false and \
		in_range == true:
			left = true
			in_motion = true
			$AnimatedSprite.play("switch_right_to_left")
			
			lever_count.count -= 1
			on_screen_counter.text = str(lever_count.count)
			$AudioStreamPlayer.play()
		
		elif left == true:
			$AnimatedSprite.play("left_idle")
		
		else:
			$AnimatedSprite.play("right_idle")
	

func _on_AnimatedSprite_animation_finished():
	"""
	Handles completion of lever animations.
	"""
	if left == true:
		$AnimatedSprite.play("left_idle")
		in_motion = false
	else:
		$AnimatedSprite.play("right_idle")
		in_motion = false


func _on_Lever_Floor_area_entered(area):
	in_range = true

func _on_Lever_Floor_area_exited(area):
	in_range = false

func _on_Lever_Floor2_area_entered(area):
	in_range = true

func _on_Lever_Floor2_area_exited(area):
	in_range = false

func _on_Lever_Floor3_area_entered(area):
	in_range = true

func _on_Lever_Floor3_area_exited(area):
	in_range = false

func _on_Lever_Floor4_area_entered(area):
	in_range = true

func _on_Lever_Floor4_area_exited(area):
	in_range = false

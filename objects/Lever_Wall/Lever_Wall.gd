extends Area2D

var up = true
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
		if Input.is_action_just_pressed("ui_accept") and up == true and \
		in_range == true:
			up = false
			in_motion = true
			$AnimatedSprite.play("switch_up_to_down")
			
			lever_count.count += 1
			on_screen_counter.text = str(lever_count.count)
			$AudioStreamPlayer.play()
		
		elif Input.is_action_just_pressed("ui_accept") and up == false and \
		in_range == true:
			up = true
			in_motion = true
			$AnimatedSprite.play("switch_down_to_up")
			
			lever_count.count -= 1
			on_screen_counter.text = str(lever_count.count)
			$AudioStreamPlayer.play()
			
		elif up == true:
			$AnimatedSprite.play("up_idle")
		
		else:
			$AnimatedSprite.play("down_idle")
	

func _on_AnimatedSprite_animation_finished():
	"""
	Handles completion of lever animations.
	"""
	if up == true:
		$AnimatedSprite.play("up_idle")
		in_motion = false
	else:
		$AnimatedSprite.play("down_idle")
		in_motion = false


func _on_Lever_Wall_area_entered(area):
	in_range = true

func _on_Lever_Wall_area_exited(area):
	in_range = false


func _on_Lever_Wall2_area_entered(area):
	in_range = true

func _on_Lever_Wall2_area_exited(area):
	in_range = false

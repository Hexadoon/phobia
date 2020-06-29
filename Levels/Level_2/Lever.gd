extends Area2D

var left = true
var in_motion = false
var in_range = false

export (String) var num_tile
var tile

var sfx

func _ready():
	tile = get_parent().get_parent().get_node(num_tile)
	sfx = get_parent().get_parent().get_node("Lever Sound")

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
			tile.visible = false
			tile.set_collision_layer(2)
			sfx.play()
		
		elif Input.is_action_just_pressed("ui_accept") and left == false and \
		in_range == true:
			left = true
			in_motion = true
			$AnimatedSprite.play("switch_right_to_left")
			sfx.play()
		
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

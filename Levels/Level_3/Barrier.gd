extends KinematicBody2D

const SPEED = 300
var motion = Vector2()
onready var sfx = $"AudioStreamPlayer2D"
onready var timer = 0
onready var overlap = $"Area2D".get_overlapping_areas()
onready var key_node = get_parent().get_parent().get_node("Keys/Key")

func _process(delta):
	"""
	Moves at a constant speed to right.
	"""
	motion.x = SPEED
	motion = move_and_slide(motion)
	
	if timer == 200:
		sfx.play()
	timer += 1


func _on_Area2D_area_entered(area):
	overlap = $"Area2D".get_overlapping_areas()
	"""
	Death Barrier that will cause a scene reset.
	"""
	if overlap[0] == key_node:
		pass
	else:
		print("DEATH BY MOVING DEATH BARRIER")
		get_tree().reload_current_scene()


func _on_AudioStreamPlayer2D_finished():
	timer = 0

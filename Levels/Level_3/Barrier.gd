extends KinematicBody2D

const SPEED = 200
var motion = Vector2()

func _process(delta):
	"""
	Moves at a constant speed to right.
	"""
	motion.x = SPEED
	motion = move_and_slide(motion)


func _on_Area2D_area_entered(area):
	"""
	Death Barrier that will cause a scene reset.
	"""
	print("DEATH BY MOVING DEATH BARRIER")
	get_tree().reload_current_scene()

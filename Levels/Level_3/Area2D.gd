extends Area2D

const SPEED = 100

var motion = Vector2()

func _process(delta):
	motion.x = SPEED
	motion = move_and_slide(motion)

func _on_Area2D_area_entered(area):
	"""
	Death Barrier that will cause a scene reset.
	"""
	get_tree().reload_current_scene()

extends KinematicBody2D

const SPEED = 100
var motion = Vector2()

func _process(delta):
	motion.x = SPEED
	motion = move_and_slide(motion)
	print("I moved")

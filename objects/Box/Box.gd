extends RigidBody2D

const GRAVITY = 500

func _ready():
	set_friction(1)
	set_linear_damp(100)
	set_gravity_scale(GRAVITY)

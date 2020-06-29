extends RigidBody2D

const FRICTION = 1
const LINEAR_DAMP = 100
const GRAVITY = 500

func _ready():
	set_friction(FRICTION)
	set_linear_damp(LINEAR_DAMP)
	set_gravity_scale(GRAVITY)

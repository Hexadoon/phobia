extends Area2D

var is_pushed = false
var overlap

func _ready():
	$AnimatedSprite.play("plate_inactive")

func _physics_process(delta):
	overlap = get_overlapping_areas()

func _on_Pressure_Plate_area_entered(area):
	is_pushed = true
	$AnimatedSprite.play("plate_active")

func _on_Pressure_Plate_area_exited(area):
	if overlap.size() > 1:
		pass
	else:
		is_pushed = false
		$AnimatedSprite.play("plate_inactive")

extends Area2D

var is_pushed1 = false
var is_pushed2 = false
var is_pushed3 = false
var is_pushed4 = false
var overlap

func _ready():
	$AnimatedSprite.play("plate_inactive")

func _physics_process(delta):
	overlap = get_overlapping_areas()

func _on_Pressure_Plate_area_entered(area):
	is_pushed1 = true
	$AnimatedSprite.play("plate_active")

func _on_Pressure_Plate_area_exited(area):
	if overlap.size() > 1:
		pass
	else:
		is_pushed1 = false
		$AnimatedSprite.play("plate_inactive")

func _on_Pressure_Plate_2_area_entered(area):
	is_pushed2 = true
	$AnimatedSprite.play("plate_active")

func _on_Pressure_Plate_2_area_exited(area):
	if overlap.size() > 1:
		pass
	else:
		is_pushed2 = false
		$AnimatedSprite.play("plate_inactive")

func _on_Pressure_Plate_3_area_entered(area):
	is_pushed3 = true
	$AnimatedSprite.play("plate_active")

func _on_Pressure_Plate_3_area_exited(area):
	if overlap.size() > 1:
		pass
	else:
		is_pushed3 = false
		$AnimatedSprite.play("plate_inactive")

func _on_Pressure_Plate_4_area_entered(area):
	is_pushed4 = true
	$AnimatedSprite.play("plate_active")

func _on_Pressure_Plate_4_area_exited(area):
	if overlap.size() > 1:
		pass
	else:
		is_pushed4 = false
		$AnimatedSprite.play("plate_inactive")

extends Node2D

var pressure_plate_1
var pressure_plate_2
var pressure_plate_3
var pressure_plate_4
var invisible_floors
var invisible_walls
var floor1
var floor2
var floor3
var key

var firstplate = false
var secondplate = false
var thirdplate = false

onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	pressure_plate_1 = get_node("Plates/Pressure Plate 1")
	pressure_plate_2 = get_node("Plates/Pressure Plate 2")
	pressure_plate_3 = get_node("Plates/Pressure Plate 3")
	pressure_plate_4 = get_node("Plates/Pressure Plate 4")
	invisible_floors = get_node("Invisible Floors/TileMap")
	invisible_walls = get_node("Invisible Walls/TileMap")
	floor1 = get_node("Invisible Walls/Floor1")
	floor2 = get_node("Invisible Walls/Floor2")
	floor3 = get_node("Invisible Walls/Floor3")
	key = get_node("Keys/Key")
	$AudioStreamPlayer.play()
	

func _physics_process(delta):
	if pressure_plate_1.is_pushed1:
		invisible_floors.set_collision_layer(1)
		invisible_floors.visible = true
		invisible_walls.set_collision_layer(2)
		invisible_walls.visible = false
	if pressure_plate_2.is_pushed2:
		firstplate = true
		floor2.visible = true
		floor2.set_collision_layer(1)
	if pressure_plate_3.is_pushed3 and !firstplate:
		floor1.visible = true
		floor2.visible = true
		floor1.set_collision_layer(1)
		floor2.set_collision_layer(1)
		floor3.visible = true
		floor3.set_collision_layer(1)
	elif pressure_plate_3.is_pushed3:
		secondplate = true
		floor3.visible = true
		floor3.set_collision_layer(1)
	if pressure_plate_4.is_pushed4 and (!firstplate or !secondplate):
		floor1.visible = true
		floor1.set_collision_layer(1)
		floor2.visible = true
		floor3.visible = true
		floor2.set_collision_layer(1)
		floor3.set_collision_layer(1)
	elif pressure_plate_4.is_pushed4:
		thirdplate = true
		floor1.visible = true
		floor1.set_collision_layer(1)
	if firstplate and secondplate and thirdplate:
		player_vars.FLAG = true
		if !key.hold:
			key.visible = true
	else:
		player_vars.FLAG = false

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()

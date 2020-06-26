extends Area2D

var cango = false
var delay = 0
var key


onready var player_vars = get_node("/root/PlayerVariables")

export(String, FILE, "*.tscn") var world_scene

func _ready():
	key = get_parent().get_parent().get_node("Keys/Key")

func _physics_process(delta):
	if delay == 0:
		if Input.is_action_just_pressed("ui_accept") and cango == true:
			print("player unlocked door")
			delay = 1
		elif Input.is_action_just_pressed("ui_accept") and cango == false:
			print("door is locked")
		else:
			$AnimatedSprite.play("locked_door_close")
	elif delay < 70:
		$AnimatedSprite.play("locked_door_open")
		delay += 1
	else:
		player_vars.FLAG = false
		get_tree().change_scene(world_scene)

func _on_Door_Locked_area_entered(area):
	if key.hold == true:
		cango = true

func _on_Door_Locked_area_exited(area):
	cango = false

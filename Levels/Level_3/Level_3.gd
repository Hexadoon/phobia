extends Node2D

onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	$AudioStreamPlayer.play()

func _process(delta):
	player_vars.FLAG = true

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()

extends Node2D

onready var background_audio = $"Background Music"
onready var key = get_node("Keys/Key")
onready var player_vars = get_node("/root/PlayerVariables")

func _ready():
	background_audio.play()

func _physics_process(delta):
	if player_vars.FLAG:
		if !key.hold:
			key.visible = true
		else:
			key.visible = false

func _on_Background_Music_finished():
	background_audio.play()

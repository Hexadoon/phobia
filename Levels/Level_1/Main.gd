extends Node2D

onready var background_audio = $"Background Music"

func _ready():
	background_audio.play()

func _on_Background_Music_finished():
	if background_audio.volume_db < -20:
		background_audio.volume_db += 10
	background_audio.play()

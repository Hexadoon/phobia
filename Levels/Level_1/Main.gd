extends Node2D

onready var background_audio = $"Background Music"

func _ready():
	background_audio.play()

func _on_Background_Music_finished():
	background_audio.play()

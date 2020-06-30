extends Node2D

var timer = 200

func _ready():
	$AudioStreamPlayer.play()

func _process(delta):
	if timer == 500:
		$Bats.play()
	timer += 1

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()

func _on_Bats_finished():
	timer = 0

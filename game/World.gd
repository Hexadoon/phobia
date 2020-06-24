extends Node2D

func _ready():
	$AudioStreamPlayer2D.play()

func _on_AudioStreamPlayer2D_finished():
	if $AudioStreamPlayer2D.volume_db < -20:
		$AudioStreamPlayer2D.volume_db += 10
	$AudioStreamPlayer2D.play()

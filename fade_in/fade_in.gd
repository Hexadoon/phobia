extends ColorRect

signal fade_finished


func fade_in():
	"""
	Plays custom Fade In animation.
	"""
	$AnimationPlayer.play("Fade_In")

func _on_AnimationPlayer_animation_finished(anim_name):
	"""
	Called once Fade In animation is finished.
	"""
	emit_signal("fade_finished")


func _on_Fade_In_fade_finished():
	pass # Replace with function body.

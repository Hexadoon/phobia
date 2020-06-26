extends Area2D

func _on_Death_Barrier_area_entered(area):
	"""
	Death Barrier that will cause a scene reset.
	"""
	get_tree().reload_current_scene()

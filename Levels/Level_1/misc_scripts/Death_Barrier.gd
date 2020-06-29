extends Area2D

func _on_Death_Barrier_area_entered(area):
	"""
	Death Barrier that will cause a scene reset.
	"""
	print("ENTERED")
	get_tree().reload_current_scene()

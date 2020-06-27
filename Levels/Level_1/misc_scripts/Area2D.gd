extends Area2D

func _on_Area2D_area_entered(area):
	get_tree().reload_current_scene()

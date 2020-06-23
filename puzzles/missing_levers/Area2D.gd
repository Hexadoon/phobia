extends Area2D

var count

export(String, FILE, "*.tscn") var world_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	count = 0

func _on_Area2D_area_entered(area):
	"""
	Determines win condition of puzzle.
	"""
	if count == 3:
		print("Puzzle complete... you win!")
	else:
		print("Try a different amount of levers")
		
	# Could add a door that takes you to a diff part of puzzle
	# if you are wrong or right?
	
	# Can replace with a door that can only open when ghe count reaches
	# a certain number etc.

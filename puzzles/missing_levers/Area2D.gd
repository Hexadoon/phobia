extends Area2D

var count
onready var player_vars = get_node("/root/PlayerVariables")

export(String, FILE, "*.tscn") var world_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	count = 0

func _on_Area2D_area_entered(area):
	"""
	Determines win condition of puzzle.
	"""
	if count == 3:
		player_vars.FLAG = true
		get_tree().change_scene(world_scene)
	else:
		get_tree().reload_current_scene()

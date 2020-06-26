extends Node

"""
FLAG will determine if the player is able to open a horizontal
sliding door. FLAG is initially set to false, and is only 
switched to true when a certain puzzle has been complete.

FLAG is reset back to false after the player progresses to the 
next level / scene. (Typically via a locked door)
"""
var FLAG = false

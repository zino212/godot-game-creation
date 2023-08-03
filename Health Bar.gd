extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Life2").hide()
	get_node("Life1").hide()
	
func set_lives(lives):
	if lives == 3:
		get_node("Life3").show()
	elif lives == 2:
		get_node("Life3").hide()
		get_node("Life2").show()
	elif lives == 1:
		get_node("Life2").hide()
		get_node("Life1").show()
	else:
		get_node("Life1").hide()

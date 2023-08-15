extends Node2D

#-----------------------------------------------------------------
# Show amount of missiles in storage

func set_missiles(missiles):
	if missiles == 3:
		get_node("Box/Missile3").show()
		get_node("Box/Missile2").show()
		get_node("Box/Missile1").show()
	elif missiles == 2:
		get_node("Box/Missile3").hide()
		get_node("Box/Missile2").show()
		get_node("Box/Missile1").show()
	elif missiles == 1:
		get_node("Box/Missile3").hide()
		get_node("Box/Missile2").hide()
		get_node("Box/Missile1").show()
	else:
		get_node("Box/Missile3").hide()
		get_node("Box/Missile2").hide()
		get_node("Box/Missile1").hide()

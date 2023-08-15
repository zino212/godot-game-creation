extends Node2D

var types = [0,1,2]

var type = types[randi() % types.size()]

#-----------------------------------------------------------------
# Set the type of the item and show the belonging sprite

func _ready():
	$ShieldSprite.hide()
	$MissileSprite.hide()
	$HeartSprite.hide()
	if type == 0:
		$ShieldSprite.show()
	elif type == 1:
		$MissileSprite.show()
	elif type == 2:
		$HeartSprite.show()

#-----------------------------------------------------------------

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#-----------------------------------------------------------------

func get_item_type() -> int:
	return type # for getting the item type in main

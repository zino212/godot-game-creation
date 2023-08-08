extends Node2D

var type

func _ready():
	var types = [0,1,2]
	type = types[randi() % types.size()]
	if type == 0:
		$ShieldSprite.show()
		$MissileSprite.hide()
		$HeartSprite.hide()
	elif type == 1:
		$ShieldSprite.hide()
		$MissileSprite.show()
		$HeartSprite.hide()
	elif type == 2:
		$ShieldSprite.hide()
		$MissileSprite.hide()
		$HeartSprite.show()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func get_item_type() -> int:
	return type

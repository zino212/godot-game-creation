extends AnimatedSprite2D

func shootMissile():
	show()
	play("shotsFired")

func _on_animation_finished():
	hide()

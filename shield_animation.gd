extends AnimatedSprite2D

func reset():
	play("Empty")

func startup():
	play("Startup")
	await animation_finished
	play("Idle")

func shutdown():
	play("Shutdown")
	await animation_finished
	play("Empty")

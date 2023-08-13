extends Node2D

func _ready():
	#var obstacle_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	#$AnimatedSprite2D.play(obstacle_types[randi() % obstacle_types.size()])
	pass

func _process(_delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


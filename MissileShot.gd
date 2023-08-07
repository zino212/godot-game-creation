extends Node2D

func _ready():
	$Dust.one_shot = true
	$Debris.one_shot = true
	$Sparks.play("Explosion")
<<<<<<< HEAD
	$AudioStreamPlayer.play()
=======
>>>>>>> bfb0ee6 (Add screen shake and explosion)

extends AudioStreamPlayer

var shield_audio = preload("res://Audio/powerUp.wav")
var missile_audio = preload("res://Audio/laserShoot.wav")
var heart_audio = preload("res://Audio/lifeUp.wav")


func play_audio(type):
	if type == 0:
		stream = shield_audio
	elif type == 1:
		stream = missile_audio
	elif type == 2:
		stream = heart_audio
	play()

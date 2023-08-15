extends AudioStreamPlayer

var shield_audio = preload("res://Audio/powerUp.wav")
var missile_audio = preload("res://Audio/laserShoot.wav")
var heart_audio = preload("res://Audio/lifeUp.wav")

var hurt_audio = preload("res://Audio/hitHurt.wav")

var countdown = hurt_audio

#-----------------------------------------------------------------

func play_item_audio(type):
	if type == 0:
		stream = shield_audio
	elif type == 1:
		stream = missile_audio
	elif type == 2:
		stream = heart_audio
	play()

func play_hurt_audio():
	stream = hurt_audio
	play()

func play_countdown():
	stream = countdown
	play()

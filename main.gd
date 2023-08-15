extends Node

var score
var lives

var obstacle_scene = preload("res://Scenes/obstacle.tscn")
var obs_velocity

var velocity_multiplier = 5
var item_interval = 15
var missile_storage = 3

var explosion_scene = preload("res://Scenes/explosion.tscn")

var item_scene = preload("res://Scenes/item.tscn")
var item_type
var shield = false
var missile = false

var music = true
var sound = true
signal shoot_pulse

signal speed

func _process(_delta):
	show_countdown()
	
	if $ShieldTimer.time_left < 3 and $ShieldTimer.time_left > 0:
		$Player/ShieldAnimation.shutdown()
	
	if Input.is_action_just_pressed("shoot_pulse") and $StartTimer.time_left == 0 and missile_storage > 0:
		use_missile()

func new_game():
	
	$ObstacleTimer.stop()
	$ItemTimer.stop()
	$ScoreTimer.stop()
	
	shield = false
	$Player/ShieldAnimation.hide()
	$Player/ShieldAnimation.reset()
	
	score = 0
	lives = 3
	obs_velocity = 100.0
	$ObstacleTimer.wait_time = 4
	$ItemTimer.wait_time = item_interval
	
	$HUD.update_missiles(missile_storage)
	
	get_tree().call_group("objects", "queue_free")
	
	$HUD.update_score(score)
	$HUD.update_lives(lives)
	$HUD.show_message("Get ready!")
	$Player.show()
	
	$StartTimer.start()
	if sound == true:
		$Countdown.play()
	
	if music == true:
		$Music.play()

func increase_difficulty():
	if (score >= 9) and ((score % 10) == 0):
		obs_velocity += velocity_multiplier
		$InfiniteScrollBackground.increase_speed(velocity_multiplier)
		if $ObstacleTimer.wait_time > 1:
			$ObstacleTimer.wait_time -= 0.2

func show_countdown():
	if ($StartTimer.time_left <= 4) and not ($StartTimer.time_left < 1):
		$HUD.show_message(str(int($StartTimer.time_left)))
		
	if ($StartTimer.time_left < 1) and ($StartTimer.time_left > 0):
		$HUD.show_message("Go!")
	elif not ($ScoreTimer.is_stopped()):
		$HUD.show_message("")
		$HUD.hide_message()

func _on_obstacle_timer_timeout():
	if missile == false:
		spawn_obstacle()
	

func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()

	var obstacle_spawn_location = get_node("ObjectPath/ObjectSpawnLocation")
	obstacle_spawn_location.progress_ratio = randf()

	var direction = obstacle_spawn_location.rotation + PI / 2

	obstacle.position = obstacle_spawn_location.position

	obstacle.rotation = direction

	var velocity = Vector2(obs_velocity, 0.0)
	obstacle.linear_velocity = velocity.rotated(direction)

	add_child(obstacle)

func _on_start_timer_timeout():
	spawn_obstacle()
	$ObstacleTimer.start()
	$ItemTimer.start()
	$ScoreTimer.start()
	$Player.start_game()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	increase_difficulty()
	

func set_item_type(t):
	item_type = t

func _on_player_hit(body):
	if "Item" in str(body):
		if sound == true:
			$AudioPlayer.play_item_audio(item_type)
		if item_type == 0:
			add_shield()
		elif item_type == 1:
			add_missile()
		elif item_type == 2:
			add_life()
	elif shield == false and $HurtTimer.time_left == 0:
		$Player.blink()
		$Camera2D.shake(.3,50,7)
		check_for_lives()
		$HurtTimer.start()
	body.queue_free()

func add_shield():
	shield = true
	$Player.shield_active()
	$ShieldTimer.start()
	$Player/ShieldAnimation.show()
	$Player/ShieldAnimation.startup()

func add_missile():
	missile_storage += 1
	if missile_storage > 3:
		use_missile()
	$HUD.update_missiles(missile_storage)

func use_missile():
	missile_storage -= 1
	missile = true
	$MissileTimer.start()
	get_tree().call_group("obstacles", "queue_free")
	$Player/MissileShot.shootMissile()
	$HUD.update_missiles(missile_storage)
	if sound == true:
		$AudioPlayer.play_item_audio(1)

func add_life():
	if lives < 3:
		lives += 1
		$HUD.update_lives(lives)

func check_for_lives():
	lives -= 1
	$HUD.update_lives(lives)
	if lives == 0:
		game_over()
	elif sound == true:
		$AudioPlayer.play_hurt_audio()

func game_over():
	$ScoreTimer.stop()
	$ObstacleTimer.stop()
	$ItemTimer.stop()
	$HurtTimer.stop()
	var explosion = explosion_scene.instantiate()
	explosion.global_position = $Player.position
	add_child(explosion)
	$Camera2D.shake(.3,50,7)
	
	get_tree().call_group("objects", "queue_free")
	
	$HUD.show_game_over()
	$Player.hide()
	$Music.stop()


func _on_item_timer_timeout():
	var item = item_scene.instantiate()

	var item_spawn_location = get_node("ObjectPath/ObjectSpawnLocation")
	item_spawn_location.progress_ratio = randf()

	var direction = item_spawn_location.rotation + PI / 2
	item.position = item_spawn_location.position

	item.rotation = direction
	
	var velocity = Vector2(obs_velocity, 0.0)
	item.linear_velocity = velocity.rotated(direction)
	
	item_type = item.get_item_type()
	
	add_child(item)

func _on_shield_timer_timeout():
	shield = false
	$Player.shield_not_active()
	$Player/ShieldAnimation.hide()


func _on_hurt_timer_timeout():
	$Player.normal_animation()


func _on_missile_timer_timeout():
	missile = false


func _on_missile_shot_animation_finished():
	$Player/MissileShot.hide()


func _on_hud_change_difficulty(settings):
	if settings[0] == 0:
		velocity_multiplier = 2.5
	elif settings[0] == 1:
		velocity_multiplier = 5
	else:
		velocity_multiplier = 10
	
	if settings[1] == 0:
		item_interval = 10
	elif settings[1] == 1:
		item_interval = 25
	else:
		item_interval = 50
	
	if settings[2] == 2:
		missile_storage = 3
	else:
		missile_storage = settings[2]

func _on_hud_change_sound(sound_settings):
	if music == false and bool(sound_settings[0]) == true:
		$Music.play()
	music = bool(sound_settings[0])
	sound = bool(sound_settings[1])
	if music == false:
		$Music.stop()

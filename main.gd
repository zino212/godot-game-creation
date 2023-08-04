extends Node

var score
var lives

var obstacle_scene = preload("res://obstacle.tscn")
var obs_velocity

var item_scene = preload("res://item.tscn")
var item_type
var shield = false

func _ready():
	pass

func _process(_delta):
	show_timer()
	increase_difficulty()

func new_game():
	
	$ObstacleTimer.stop()
	$ItemTimer.stop()
	$ScoreTimer.stop()
	
	shield = false
	score = 0
	lives = 3
	obs_velocity = 150.0
	$ObstacleTimer.wait_time = 3
	$ItemTimer.wait_time = 10
	
	get_tree().call_group("obstacles", "queue_free")
	$HUD.update_score(score)
	$HUD.update_lives(lives)
	$HUD.show_message("Get ready!")
	$Player.show()
	$StartTimer.start()

func increase_difficulty():
	if (score >= 9) and ((score % 10) == 0):
		obs_velocity += 1.0
		if $ObstacleTimer.wait_time > 1:
			$ObstacleTimer.wait_time -= 0.2

func show_timer():
	if ($StartTimer.time_left <= 4) and not ($StartTimer.time_left < 1):
		$HUD.show_message(str(int($StartTimer.time_left)))
	elif ($StartTimer.time_left < 1) and not ($ScoreTimer.is_stopped()):
		$HUD.show_message("")
	

func _on_obstacle_timer_timeout():
	spawn_obstacle()
	

func spawn_obstacle():
	var obstacle = obstacle_scene.instantiate()

	var obstacle_spawn_location = get_node("ObstaclePath/ObstacleSpawnLocation")
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

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func set_item_type(t):
	item_type = t

func _on_player_hit(body):
	if "Item" in str(body):
		if item_type == 0:
			add_shield()
		elif item_type == 1:
			add_missile()
		elif item_type == 2:
			add_life()
	elif shield == false:
		blink_player()
		check_for_lives()

func add_shield():
	shield = true
	$ShieldTimer.start()

func add_missile():
	pass	

func add_life():
	if lives < 3:
		lives += 1
		$HUD.update_lives(lives)

func check_for_lives():
	lives -= 1
	$HUD.update_lives(lives)
	if lives == 0:
		game_over()

func blink_player():
	pass

func game_over():
	$ScoreTimer.stop()
	$ObstacleTimer.stop()
	$ItemTimer.stop()
	$HUD.show_game_over()
	$Player.hide()


func _on_item_timer_timeout():
	var item = item_scene.instantiate()

	var item_spawn_location = get_node("ObstaclePath/ObstacleSpawnLocation")
	item_spawn_location.progress_ratio = randf()

	var direction = item_spawn_location.rotation + PI / 2

	item.position = item_spawn_location.position

	item.rotation = direction

	var velocity = Vector2(obs_velocity, 0.0)
	item.linear_velocity = velocity.rotated(direction)
	add_child(item)
	item_type = item.get_item_type()


func _on_shield_timer_timeout():
	shield = false

extends Node

var obstacle_scene = preload("res://obstacle.tscn")
var score
var lives

var obs_velocity

func _ready():
	pass

func _process(_delta):
	show_timer()
	increase_difficulty()

func new_game():
	score = 0
	lives = 3
	obs_velocity = 150.0
	$ObstacleTimer.wait_time = 3
	
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
	$ScoreTimer.start()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_player_hit():
	blink_player()
	check_for_lives()

func check_for_lives():
	lives -= 1
	$HUD.update_lives(lives)
	if lives == 0:
		game_over()

func blink_player():
	$Player.take_damage(1)

func game_over():
	$ScoreTimer.stop()
	$ObstacleTimer.stop()
	$HUD.show_game_over()
	$Player.hide()

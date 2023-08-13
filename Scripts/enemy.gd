extends CharacterBody2D

var speed = 100
var player_position
var target_position
@onready var player = get_parent().get_node("Player")

func _physics_process(_delta):
	player_position = player.position
	velocity = position.direction_to(player_position) * speed
	if position.distance_to(player_position) > 3:
		move_and_slide()


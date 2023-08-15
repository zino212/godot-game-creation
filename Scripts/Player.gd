extends Area2D

@export var speed = 400

signal damaged
signal killed
signal hit(body)

var screen_size

var shield = false
var game_started = false

var hp = HP_MAX
const HP_MAX = 100.0

#-----------------------------------------------------------------

func _ready():
	screen_size = get_viewport_rect().size
	normal_animation()

#-----------------------------------------------------------------
# Set various variables by calling these methods in main

func shield_active():
	shield = true

func shield_not_active():
	shield = false

func start_game():
	game_started = true

#-----------------------------------------------------------------
# Manage the different animations of the player

func normal_animation():
	$Sprite2D.play("default")
	
func brake():
	$Sprite2D.play("brake_idle")
	await $Sprite2D.animation_looped
	$Sprite2D.play("default")

func acceleration():
	$Sprite2D.play("acceleration")
	await $Sprite2D.animation_looped
	$Sprite2D.play("default")

func blink():
	$Sprite2D.play("hurt")

#-----------------------------------------------------------------
# Movement of player and playing the animations

func _process(delta):
	var velocity = Vector2.ZERO
	if game_started: # block movement until countdown finishes
		if Input.is_action_pressed("move_right"):
			velocity.x += 250
			if shield == false: # wheelie only when no shield is present
				acceleration()
		if Input.is_action_pressed("move_left"):
			brake()
			velocity.x -= 250
		if Input.is_action_pressed("move_down"):
			velocity.y += 250
		if Input.is_action_pressed("move_up"):
			velocity.y -= 250
		
		position += velocity * delta
		position.x = clamp(position.x, 80, screen_size.x - 80) # limit player movement to screen size
		position.y = clamp(position.y, screen_size.y/2 + 100, screen_size.y - 40)

#-----------------------------------------------------------------

func _on_body_entered(body):
	body.hide()
	hit.emit(body)


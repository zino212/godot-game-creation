extends Area2D
signal hit(body)

@export var speed = 400
var screen_size

signal damaged
signal killed

var shield = false
var game_started = false

const HP_MAX = 100.0
var hp = HP_MAX

func take_damage(impact):
	impact = clamp(impact, 0.0, 1.0)
	var damage = HP_MAX * impact
	var prev_hp = hp
	hp -= damage
	hp = clamp(hp, 0, HP_MAX)

	if prev_hp != hp:
		emit_signal("damaged", damage)

	if hp <= 0.0:
		emit_signal("killed")
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	normal_animation()

func shield_active():
	shield = true

func shield_not_active():
	shield = false

func start_game():
	game_started = true

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

func _process(delta):
	var velocity = Vector2.ZERO
	if game_started:
		if Input.is_action_pressed("move_right"):
			velocity.x += 250
			if shield == false:
				acceleration()
		if Input.is_action_pressed("move_left"):
			brake()
			velocity.x -= 250
		if Input.is_action_pressed("move_down"):
			velocity.y += 250
		if Input.is_action_pressed("move_up"):
			velocity.y -= 250
		
		position += velocity * delta
		position.x = clamp(position.x, 80, screen_size.x - 80)
		position.y = clamp(position.y, screen_size.y/2 + 100, screen_size.y - 40)

func _on_body_entered(body):
	body.hide()
	hit.emit(body)

func blink():
	$Sprite2D.play("hurt")


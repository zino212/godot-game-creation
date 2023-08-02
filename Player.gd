extends Area2D
signal hit

@export var speed = 400
var screen_size

signal damaged
signal killed

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

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 250
	if Input.is_action_pressed("move_left"):
		velocity.x -= 250
	if Input.is_action_pressed("move_down"):
		velocity.y += 250
	if Input.is_action_pressed("move_up"):
		velocity.y -= 250
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, screen_size.y/2 + 60, screen_size.y - 30)

	position.y = clamp(position.y, screen_size.y/2, screen_size.y - 100)

func _on_body_entered(body):
	hit.emit()

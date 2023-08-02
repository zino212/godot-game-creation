extends Area2D
signal hit

@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_down"):
		velocity.y += 250
	if Input.is_action_pressed("move_up"):
		velocity.y -= 250
	
	position += velocity * delta
	position.y = clamp(position.y, screen_size.y/2, screen_size.y - 100)


func _on_body_entered(_body):
	hit.emit()

extends ParallaxBackground


@export var velocity= 100.0

@export var direction = Vector2.LEFT

func _ready():
	get_parent().get_parent().get_node("Main").connect("speed", _increase_speed)

func _process(delta):
	scroll_base_offset += (velocity * direction) * delta
	
func _increase_speed():
	velocity+=50

extends ParallaxBackground


@export var velocity= 100.0

@export var direction = Vector2.LEFT

func _ready():
	pass

func _process(delta):
	scroll_base_offset += (velocity * direction) * delta
	
func increase_speed(modifier):
	velocity += modifier

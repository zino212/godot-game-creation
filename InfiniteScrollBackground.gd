extends ParallaxBackground

@export var speed = 100.0

@export var direction = Vector2.LEFT

func _process(delta):
	scroll_base_offset += (speed * direction) * delta
	

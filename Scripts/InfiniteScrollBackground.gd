extends ParallaxBackground

@export var velocity= 100.0

@export var direction = Vector2.LEFT

#-----------------------------------------------------------------
# Lettomg the background move

func _process(delta):
	scroll_base_offset += (velocity * direction) * delta

#-----------------------------------------------------------------
# Increasing the speed of the moving background

func increase_speed(modifier):
	velocity += modifier

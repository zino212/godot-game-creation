extends CanvasLayer

signal escape

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		push_escape()


func _on_start_button_pressed():
	visible = not visible


func push_escape():
	visible = not visible

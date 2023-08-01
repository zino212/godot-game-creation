extends CanvasLayer

signal escape

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	visible = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		push_escape()

func start_game():
	pass

func _on_start_button_pressed():
	visible = false
	get_tree().paused = false
	start_game()


func push_escape():
	if visible:
		visible = false
		get_tree().paused = false
	else:
		visible = true
		get_tree().paused = true

func show_settings():
	$Menu.visible = false
	$Settings.visible = true


func _on_settings_apply_button_pressed(settings):
	update_settings(settings)
	
func update_settings(settings: Dictionary) -> void:
	
	DisplayServer.window_set_size(settings.resolution)
	
	if settings.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	if settings.vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
	$Settings.visible = false
	$Menu.visible = true

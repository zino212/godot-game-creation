extends CanvasLayer

signal escape

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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
	var screen_size = DisplayServer.screen_get_size()
	#var window = get_editor_interface().get_window()
	#if settings.fullscreen:
	#	window.mode = Window.MODE_WINDOWED
	#else:
	#	window.mode = Window.MODE_FULLSCREEN
	#get_tree().set_screen_stretch(
	#	SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, settings.resolution
	#)
	#OS.set_window_size(settings.resolution)
	#OS.vsync_enabled = settings.vsync
	$Settings.visible = false
	$Menu.visible = true

extends CanvasLayer

signal escape
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	visible = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		push_escape()

func _on_start_button_pressed():
	$Menu.hide()
	get_tree().paused = false
	start_game.emit()
	$ScoreLabel.show()
	$LifeLabel.show()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func hide_message():
	$Message.hide()

func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func update_lives(lives):
	$LifeLabel.text = str(lives) + " Lives"

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
	
<<<<<<< HEAD
func update_settings(_settings: Dictionary) -> void:
	var _screen_size = DisplayServer.screen_get_size()
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
=======
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
	
>>>>>>> 7138cb3 (Further work on menu)
	$Settings.visible = false
	$Menu.visible = true

func show_game_over():
	show_message("Game Over!")
	await $MessageTimer.timeout

	await get_tree().create_timer(1.0).timeout
	$Menu.show()

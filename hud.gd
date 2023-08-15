extends CanvasLayer

signal escape
signal start_game
signal change_difficulty(Vector3)
signal change_sound(Vector2)

var sound = true

func _ready():
	get_tree().paused = true
	visible = true
	
func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		push_escape()

func _on_start_button_pressed():
	click_audio()
	$Menu.hide()
	get_tree().paused = false
	start_game.emit()
	$ScoreLabel.show()
	$"Health Bar".show()
	$MissileBar.show()
	$Menu/VBoxContainer/Start_Button.text = "Restart"
	$Menu/VBoxContainer/Resume_Button.show()
	
func _on_resume_button_pressed():
	click_audio()
	$Menu.hide()
	get_tree().paused = false


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func hide_message():
	$Message.hide()

func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func update_lives(lives):
	$"Health Bar".set_lives(lives)

func update_missiles(missiles):
	if missiles > 0:
		$MissileBar/Panel.show()
	else:
		$MissileBar/Panel.hide()
	$MissileBar.set_missiles(missiles)

func push_escape():
	if $Message.text == "Game paused":
		show_message("")
		$Menu.visible = false
		get_tree().paused = false
	elif ($Message.text == "") and ($ScoreLabel.visible):
		show_message("Game paused")
		$Menu.visible = true
		get_tree().paused = true

func show_settings():
	click_audio()
	$Menu.visible = false
	$Settings.visible = true

func _on_settings_apply_button_pressed(settings):
	click_audio()
	update_settings(settings)
	
func update_settings(settings: Dictionary):
	if settings.resolution != Vector2(DisplayServer.window_get_size()):
		DisplayServer.window_set_size(settings.resolution)
	
	if settings.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	if settings.vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
	change_difficulty.emit(Vector3(settings.difficulty, settings.item, settings.missile))
	
	change_sound.emit(Vector2(settings.music, settings.sound))
	sound = settings.sound
	
	$Settings.visible = false
	$Menu.visible = true

func show_game_over():
	show_message("Game Over!")
	await $MessageTimer.timeout
	await get_tree().create_timer(1.0).timeout
	$Menu/VBoxContainer/Resume_Button.hide()
	$Menu/VBoxContainer/Start_Button.text = "Start Game"
	$Menu.show()


func _on_end_button_pressed():
	click_audio()
	get_tree().quit()

func show_controls():
	click_audio()
	$Menu.visible = false
	$Controls.visible = true


func _on_back_button_pressed():
	click_audio()
	$Controls.visible = false
	$Credits.visible = false
	$Menu.visible = true


func show_credits():
	click_audio()
	$Menu.visible = false
	$Credits.visible = true

func click_audio():
	if sound == true:
		$ClickAudio.play()

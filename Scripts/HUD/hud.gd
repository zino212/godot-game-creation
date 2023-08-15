extends CanvasLayer

signal escape
signal start_game
signal change_difficulty(Vector3)
signal change_sound(Vector2)

var sound = true

#-----------------------------------------------------------------
# Pause the game on startup

func _ready():
	get_tree().paused = true
	visible = true

#-----------------------------------------------------------------
# Listen for pushing escape or p for pausing the game

func _process(_delta):
	if Input.is_action_just_pressed("escape"):
		push_escape()

#-----------------------------------------------------------------
# Start the game and hide the menu, show game panels

func _on_start_button_pressed():
	click_audio()
	$Menu.hide()
	get_tree().paused = false
	start_game.emit()
	$ScoreLabel.show()
	$HealthBar.show()
	$MissileBar.show()
	$Menu/VBoxContainer/Start_Button.text = "Restart"
	$Menu/VBoxContainer/Resume_Button.show()

#-----------------------------------------------------------------
# New button just for closing the menu during a running game

func _on_resume_button_pressed():
	click_audio()
	$Menu.hide()
	get_tree().paused = false

#-----------------------------------------------------------------
# Show a message ("Game Over" or countdown at the start)

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

#-----------------------------------------------------------------
# Hide the message panel again

func hide_message():
	$Message.hide()

#-----------------------------------------------------------------
# Update score, number of lives and missiles

func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func update_lives(lives):
	$HealthBar.set_lives(lives)

func update_missiles(missiles):
	if missiles > 0:
		$MissileBar/Panel.show()
	else:
		$MissileBar/Panel.hide()
	$MissileBar.set_missiles(missiles)

#-----------------------------------------------------------------
# Pause the game and show the menu

func push_escape():
	if $Message.text == "Game paused":
		show_message("")
		$Menu.visible = false
		get_tree().paused = false
	elif ($Message.text == "") and ($ScoreLabel.visible):
		show_message("Game paused")
		$Menu.visible = true
		get_tree().paused = true

#-----------------------------------------------------------------
# Apply settings and save them

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

#-----------------------------------------------------------------
# Show menu and game over message

func show_game_over():
	show_message("Game Over!")
	await $MessageTimer.timeout
	await get_tree().create_timer(1.0).timeout
	$Menu/VBoxContainer/Resume_Button.hide()
	$Menu/VBoxContainer/Start_Button.text = "Start Game"
	$Menu.show()

#-----------------------------------------------------------------
# Closing the game

func _on_end_button_pressed():
	click_audio()
	get_tree().quit()

#-----------------------------------------------------------------
# Hide menu and show controls panel

func show_controls():
	click_audio()
	$Menu.visible = false
	$Controls.visible = true

#-----------------------------------------------------------------
# Hide menu and show credits panel

func show_credits():
	click_audio()
	$Menu.visible = false
	$Credits.visible = true

#-----------------------------------------------------------------
# Hide menu and show settings panel

func show_settings():
	click_audio()
	$Menu.visible = false
	$Settings.visible = true

#-----------------------------------------------------------------
# Get back from Controls/Credits to main menu

func _on_back_button_pressed():
	click_audio()
	$Controls.visible = false
	$Credits.visible = false
	$Menu.visible = true

#-----------------------------------------------------------------
# Play some noise on clicking buttons

func click_audio():
	if sound == true:
		$ClickAudio.play()

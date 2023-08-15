extends Panel

signal apply_button_pressed(settings)

var res = DisplayServer.window_get_size()
#-----------------------------------------------------------------
# Standard settings at the start of the game
var _settings := {
	resolution = Vector2(res),
	fullscreen = false,
	vsync = false,
	difficulty = 1,
	item = 1,
	missile = 2,
	music = true,
	sound = true
	}
	
#-----------------------------------------------------------------
# Saving the new settings
func _on_apply_button_pressed():
	emit_signal("apply_button_pressed", _settings)

#-----------------------------------------------------------------
# Making some noise on clicking buttons
func click_audio():
	if _settings.sound == true:
		$ClickAudio.play()



func _on_difficulty_selector_difficulty_changed(new_difficulty):
	click_audio()
	_settings.difficulty = new_difficulty


func _on_item_selector_item_changed(new_item):
	click_audio()
	_settings.item = new_item


func _on_missile_selector_missile_changed(new_missiles):
	click_audio()
	_settings.missile = new_missiles


func _on_resolution_selector_resolution_changed(new_resolution):
	click_audio()
	_settings.resolution = new_resolution


func _on_fullscreen_selector_toggled(is_button_pressed):
	click_audio()
	_settings.fullscreen = is_button_pressed


func _on_vsync_selector_toggled(is_button_pressed):
	click_audio()
	_settings.vsync = is_button_pressed


func _on_music_selector_toggled(button_pressed):
	click_audio()
	_settings.music = button_pressed


func _on_sounds_selector_toggled(button_pressed):
	click_audio()
	_settings.sound = button_pressed

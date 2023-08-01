extends Panel

signal apply_button_pressed(settings)

var _settings := {resolution = Vector2(640, 480), fullscreen = false, vsync = false}


# Emit the `apply_button_pressed` signal, when user presses the button.
func _on_apply_button_pressed() -> void:
	# Send the last selected settings with the signal
	emit_signal("apply_button_pressed", _settings)


# Store the resolution selected by the user. As this function is connected
# to the `resolution_changed` signal, this will be executed any time the
# users chooses a new resolution
func _on_resolution_selector_resolution_changed(new_resolution: Vector2) -> void:
	_settings.resolution = new_resolution


# Store the fullscreen setting. This will be called any time the users toggles
# the UIFullScreenCheckbox
func _on_fullscreen_selector_toggled(is_button_pressed: bool) -> void:
	_settings.fullscreen = is_button_pressed


# Store the vsync seting. This will be called any time the users toggles
# the UIVSyncCheckbox
func _on_vsync_selector_toggled(is_button_pressed: bool) -> void:
	_settings.vsync = is_button_pressed

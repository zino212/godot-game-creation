extends Panel

signal apply_button_pressed(settings)

var _settings := {resolution = Vector2(640, 480), fullscreen = false, vsync = false}

func _on_apply_button_pressed() -> void:
	emit_signal("apply_button_pressed", _settings)

func _on_resolution_selector_resolution_changed(new_resolution: Vector2) -> void:
	_settings.resolution = new_resolution

func _on_fullscreen_selector_toggled(is_button_pressed: bool) -> void:
	_settings.fullscreen = is_button_pressed

func _on_vsync_selector_toggled(is_button_pressed: bool) -> void:
	_settings.vsync = is_button_pressed

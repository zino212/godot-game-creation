extends Panel

signal apply_button_pressed(settings)
var res = DisplayServer.window_get_size()
var _settings := {resolution = Vector2(res), fullscreen = false, vsync = false}

func _on_apply_button_pressed():
	emit_signal("apply_button_pressed", _settings)

extends Panel

signal apply_button_pressed(settings)
var res = DisplayServer.window_get_size()
var _settings := {resolution = Vector2(res), fullscreen = false, vsync = false}

func _on_apply_button_pressed():
	emit_signal("apply_button_pressed", _settings)

func _on_fullscreen_check_box_toggled(button_pressed):
	_settings.fullscreen = button_pressed

func _on_vsync_check_box_toggled(button_pressed):
	_settings.vsync = button_pressed

func _on_option_button_item_selected(index):
	var text = $VBoxContainer/Resolution_Selector/OptionButton.get_item_text(index)
	var values = text.split_floats("x")
	_settings.resolution = Vector2(values[0], values[1])

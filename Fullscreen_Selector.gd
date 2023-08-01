extends HBoxContainer

signal toggled(is_button_pressed)

# Emit the `toggled` signal when the `CheckBox` state changes.
func _on_CheckBox_toggled(button_pressed: bool) -> void:
	emit_signal("toggled", button_pressed)

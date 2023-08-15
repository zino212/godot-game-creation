extends HBoxContainer

signal toggled(button_pressed)

func _on_sounds_check_box_toggled(button_pressed):
	emit_signal("toggled", button_pressed)

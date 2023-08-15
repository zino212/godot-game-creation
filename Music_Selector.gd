extends HBoxContainer

signal toggled(button_pressed)

func _on_music_check_box_toggled(button_pressed):
	emit_signal("toggled", button_pressed)

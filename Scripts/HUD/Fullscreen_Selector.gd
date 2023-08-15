#-----------------------------------------------------------------
# SCRIPT FOR EXPORTING ONE SPECIFIC SETTING
#-----------------------------------------------------------------
extends HBoxContainer

signal toggled(is_button_pressed)

func _on_fullscreen_check_box_toggled(button_pressed):
	emit_signal("toggled", button_pressed)

#-----------------------------------------------------------------
# SCRIPT FOR EXPORTING ONE SPECIFIC SETTING
#-----------------------------------------------------------------
extends HBoxContainer

signal difficulty_changed(new_difficulty)

func _update_selected_item(number):
	emit_signal("difficulty_changed", int(number))

func _on_option_button_item_selected(index):
	_update_selected_item($OptionButton.get_item_text(index))

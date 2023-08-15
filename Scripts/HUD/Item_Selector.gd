#-----------------------------------------------------------------
# SCRIPT FOR EXPORTING ONE SPECIFIC SETTING
#-----------------------------------------------------------------
extends HBoxContainer

signal item_changed(new_item)

func _update_selected_item(number):
	emit_signal("item_changed", int(number))

func _on_option_button_item_selected(index):
	_update_selected_item($OptionButton.get_item_text(index))

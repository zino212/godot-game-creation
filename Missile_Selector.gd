extends HBoxContainer

signal missile_changed(new_missiles)

func _update_selected_item(number):
	emit_signal("missile_changed", int(number))

func _on_option_button_item_selected(index):
	_update_selected_item($OptionButton.get_item_text(index))

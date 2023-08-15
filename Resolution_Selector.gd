extends HBoxContainer

signal resolution_changed(new_resolution)

func _update_selected_item(text: String):
	var values := text.split_floats("x")
	emit_signal("resolution_changed", Vector2(values[0], values[1]))

func _on_option_button_item_selected(index):
	_update_selected_item($OptionButton.get_item_text(index))

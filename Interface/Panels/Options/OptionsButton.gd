extends PanelContainer

func _on_button_pressed() -> void:
	Event.ui_toggle_menu.emit()

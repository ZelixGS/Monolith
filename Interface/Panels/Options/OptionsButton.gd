extends PanelContainer

func _on_button_pressed() -> void:
	Event.emit_signal("toggle_settings")

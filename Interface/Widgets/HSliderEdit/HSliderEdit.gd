class_name HSliderEdit extends HBoxContainer

@export var signal_name: String = ""

@onready var h_slider: HSlider = $HSlider
@onready var line_edit: LineEdit = $LineEdit

var value: float = 50.0

func update(num: float) -> void:
	h_slider.value = num
	line_edit.text = "%s%%" % str(num)
	send_signal()

func send_signal() -> void:
	if Event.has_signal(signal_name):
		Event.emit_signal(signal_name, value)

func _on_h_slider_value_changed(num: float) -> void:
	update(num)

func _on_line_edit_text_submitted(new_text: String) -> void:
	var num: int = clamp(int(new_text), 0, 100)
	update(int(num))

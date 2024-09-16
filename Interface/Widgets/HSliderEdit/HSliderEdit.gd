class_name HSliderEdit extends HBoxContainer

@export var append_percent: bool = true

signal updated(value: float)

@onready var h_slider: HSlider = $HSlider
@onready var line_edit: LineEdit = $LineEdit

func _ready() -> void:
	h_slider.value_changed.connect(_on_h_slider_value_changed)

func set_properties(min_value: float, max_value: float, step_value: float, is_rounded: bool, append_percentage: bool) -> void:
	h_slider.min_value = min_value
	h_slider.max_value = max_value
	h_slider.step = step_value
	h_slider.rounded = is_rounded
	append_percent = append_percentage

func set_value(num: float) -> void:
	h_slider.disconnect("value_changed", _on_h_slider_value_changed)
	h_slider.value = num
	update_text(str(num))
	h_slider.value_changed.connect(_on_h_slider_value_changed)

func update(num: float) -> void:
	h_slider.value = num
	update_text(str(num))
	updated.emit(num)

func update_text(num: String) -> void:
	if append_percent:
		line_edit.text = "%s%%" % num
	else:
		line_edit.text = num

func _on_h_slider_value_changed(num: float) -> void:
	update(num)

func _on_line_edit_text_submitted(new_text: String) -> void:
	var num: float = clamp(int(new_text), 0, 100)
	update(float(num))

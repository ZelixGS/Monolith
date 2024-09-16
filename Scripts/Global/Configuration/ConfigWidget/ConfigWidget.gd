@tool
extends Control

@export var setting_name: String:
	set(value):
		setting_name = value
		name = value
		call_deferred("tool_set_label")

@onready var label: Label = %Label
@onready var check_box: CheckBox = %CheckBox
@onready var btn_reset: Button = %BtnReset
@onready var h_slider: HSlider = %HSlider
@onready var line_edit: LineEdit = %LineEdit
@onready var slider: HBoxContainer = $MarginContainer/VBoxContainer/Slider

var setting: Setting

func tool_set_label() -> void:
	label.text = setting_name.capitalize()

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	if setting_name == "":
		printerr("No Setting Name on %s" % name)
		return
	setting = Configuration.get_setting(setting_name)
	setup()

func setup() -> void:
	# Hide All Elements, incase visible in editor.
	label.hide()
	check_box.hide()
	slider.hide()

	# Set all Text Elements
	label.text = setting_name.capitalize()
	check_box.text = setting_name.capitalize()
	tooltip_text = setting.details

	match setting.type:
		setting.TYPE.CHECKBOX:
			check_box.show()
			check_box.button_pressed = bool(setting.value)

		setting.TYPE.SLIDER:
			h_slider.min_value = setting.slider_minimum
			h_slider.max_value = setting.slider_maximum
			h_slider.step = setting.slider_step
			h_slider.rounded = setting.slider_rounded
			h_slider.value = setting.value
			set_line_edit(setting.value)
			slider.show()
			label.show()

func set_value(value: Variant, skip_emit: bool = false) -> void:
	match setting.type:
		setting.TYPE.CHECKBOX:
			check_box.button_pressed = bool(value)

		setting.TYPE.SLIDER:
			h_slider.value = float(value)
			set_line_edit(value)
	if not skip_emit:
		Configuration.setting_changed.emit(setting_name, value)

func set_line_edit(value: Variant) -> void:
	var new_value: float = float(value)
	if setting.slider_percentage:
		line_edit.text = "%s%%" % str(new_value*100)
	else:
		line_edit.text = "%.02f" % new_value

func _on_btn_reset_pressed() -> void:
	set_value(setting.default)

func _on_check_box_toggled(toggled_on: bool) -> void:
	set_value(toggled_on)

func _on_h_slider_value_changed(value: float) -> void:
	set_value(value)

func _on_line_edit_text_submitted(new_text: String) -> void:
	var num: float = clamp(int(new_text), setting.slider_minimum, setting.slider_maximum)
	set_value(num)

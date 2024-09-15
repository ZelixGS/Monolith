@tool
extends PanelContainer

@export var signal_name: String = ""

@onready var label: Label = $MarginContainer/VBoxContainer/Label
@onready var h_slider_edit: HSliderEdit = $MarginContainer/VBoxContainer/HSliderEdit

func _ready() -> void:
	label.text = name
	h_slider_edit.signal_name = signal_name

func _on_v_box_container_renamed() -> void:
	label.text = name

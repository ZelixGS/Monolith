@tool
@icon("./icon_dialog.png")
class_name ExtendedLabel extends HBoxContainer

enum SIDE { OFF, LEFT, RIGHT, BOTH }

@export_category("Icon")
@export var show_icon: SIDE = SIDE.LEFT:
	set(value):
		show_icon = value
		call_deferred("update_icon_position")

@export var icon: Texture = preload("./icon_interrogation.png")

@export_category("Nodes")
@export var left_icon: TextureRect
@export var label: Label
@export var right_icon: TextureRect

func set_label_text(value: Variant) -> void:
	pass

func update_icon_position() -> void:
	match show_icon:
		SIDE.OFF:
			left_icon.hide()
			right_icon.hide()
		SIDE.LEFT:
			left_icon.show()
			right_icon.hide()
		SIDE.RIGHT:
			left_icon.hide()
			right_icon.show()
		SIDE.BOTH:
			left_icon.show()
			right_icon.show()

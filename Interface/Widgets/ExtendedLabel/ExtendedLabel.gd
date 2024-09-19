@tool
@icon("./icon_dialog.png")
class_name ExtendedLabel extends HBoxContainer

var is_ready: bool = false
var previous_text: String
var previous_number: float

enum TYPE { STRING, NUMBER }
enum FORMATTING { OFF, DIGIT, PERCENTAGE }
enum ROUNDING { OFF, FLOOR, CEILING, ROUND }
enum ANIMATION { OFF, SPINNER, TYPEWRITER }
enum SIDE { OFF, LEFT, RIGHT, BOTH }

#region Exports
@export var type: TYPE = TYPE.STRING:
	set(value):
		type = value
		call_deferred("clear_text")
@export var text: String = "":
	set(value):
		previous_text = text
		text = value
		call_deferred("update_text")
@export_category("Number")
@export var number: float:
	set(value):
		previous_number = number
		number = value
		call_deferred("update_text")
@export var formatting: FORMATTING = FORMATTING.OFF:
	set(value):
		formatting = value
		call_deferred("update_text")
@export var rounding: ROUNDING = ROUNDING.OFF:
	set(value):
		rounding = value
		call_deferred("update_text")
@export var decimals: int = 2:
	set(value):
		decimals = value
		if value < -1:
			decimals = -1
		call_deferred("update_text")
@export var padding: int = 0:
	set(value):
		padding = value
		if value < 0:
			padding = 0
		call_deferred("update_text")
@export var seperator: String = ","
@export_category("Label")
@export var label_settings: LabelSettings:
	set(value):
		label_settings = value
		call_deferred("update_label_settings")

@export_category("Animation")
@export var animate: ANIMATION = ANIMATION.OFF
@export var duration: float = 0.75
@export var transition: Tween.TransitionType = Tween.TRANS_LINEAR
@export var easing: Tween.EaseType = Tween.EASE_IN

@export_category("Icon")
@export var show_icon: SIDE = SIDE.LEFT:
	set(value):
		show_icon = value
		call_deferred("update_icon_position")
@export var icon: Texture = preload("./icon_interrogation.png"):
	set(value):
		icon = value
		call_deferred("update_icon_texture")
@export var icon_color: Color = Color.WHITE:
	set(value):
		icon_color = value
		call_deferred("update_icon_color")

@export_category("Nodes")
@export var left_icon: TextureRect
@export var label: Label
@export var right_icon: TextureRect
#endregion

func _ready() -> void:
	set_deferred("is_ready", true)

#region Exposed Functions
func clear_text() -> void:
	label.text = ""

func update_text() -> void:
	match type:
		TYPE.STRING:
			match animate:
				ANIMATION.OFF:
					label.text = text
				ANIMATION.TYPEWRITER:
					label.text = text
					label.visible_ratio = 0
					var tween: Tween = get_tree().create_tween().set_trans(transition).set_ease(easing)
					tween.tween_property(label, "visible_ratio", 1, duration)
		TYPE.NUMBER:
			match animate:
				ANIMATION.OFF:
					set_number(number)
				ANIMATION.SPINNER:
					var tween: Tween = get_tree().create_tween().set_trans(transition).set_ease(easing)
					tween.tween_method(set_number, previous_number, number, duration)
				ANIMATION.TYPEWRITER:
					set_number(number)
					label.visible_ratio = 0
					var tween: Tween = get_tree().create_tween().set_trans(transition).set_ease(easing)
					tween.tween_property(label, "visible_ratio", 1, duration)

func force_update_text() -> void:
	label.text = text

#endregion

func set_number(value: float) -> void:
	value = round_number(value)
	match formatting:
		FORMATTING.OFF:
			label.text = "%0*.*f" % [padding, decimals, value]
		FORMATTING.DIGIT:
			label.text = "%s" % digit_grouping(value)
		FORMATTING.PERCENTAGE:
			label.text = "%0*.*f%%" % [padding, decimals, number*100]

#region Numbers

func round_number(value: float) -> float:
	match rounding:
		ROUNDING.OFF:
			return value
		ROUNDING.FLOOR:
			return floorf(value)
		ROUNDING.CEILING:
			return ceilf(value)
		ROUNDING.ROUND:
			return roundf(value)
	return value

func digit_grouping(value: float) -> String:
	var floored: float = floorf(value)
	var result: String = ""
	for i: int in range(0, str(floored).length()):
		if i != 0 && i % 3 == str(floored).length() % 3:
			result += seperator
		result += str(floored)[i]
	return result

#endregion

#region Label

func update_label_settings() -> void:
	label.label_settings = label_settings

#endregion


#region Icon
func update_icon_texture() -> void:
	left_icon.texture = icon
	right_icon.texture = icon

func update_icon_color() -> void:
	left_icon.self_modulate = icon_color
	right_icon.self_modulate = icon_color

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
#endregion

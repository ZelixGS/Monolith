@icon("./icon_dialog.png")
class_name ExtendedLabelOLD extends Label

@export_category("Digit Grouping")
@export var enable_digit_grouping: bool = true
@export var seperator: String = ","
@export_category("Tween Settings")
@export var animate: bool = false
@export var transition: Tween.TransitionType = Tween.TRANS_LINEAR
@export var easing: Tween.EaseType = Tween.EASE_IN
@export var duration: float = 1.0

func update_text(value: Variant, force_animate: bool = false) -> void:
	if animate or force_animate:
		var current: float = float(text)
		var final: float = float(value)
		var tween: Tween = get_tree().create_tween().set_trans(transition).set_ease(easing)
		tween.tween_method(animation, current, final, duration)
	else:
		if enable_digit_grouping:
			text = digit_grouping(value)
		else:
			text = str(value)

func animation(value: int) -> void:
	if enable_digit_grouping:
		text = digit_grouping(value)
	else:
		text = str(value)

func digit_grouping(num: Variant) -> String:
	var string: String = str(num)
	var mod: int = string.length() % 3
	var result: String = ""
	for i: int in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			result += seperator
		result += string[i]
	#if float(num) < 0:
		#result = '-'+result
	return result

class_name ExtendedSprite2D extends Sprite2D

func transition_color(to_color: Color, time: float = 0.25) -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "modulate", to_color, time)

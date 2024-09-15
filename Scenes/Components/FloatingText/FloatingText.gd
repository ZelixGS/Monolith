class_name FloatingText extends Label

func create_simple(text: String, duration: float, direction: Vector2 = Vector2.UP, color: Color = Color.WHITE) -> void:
	update_text(text, color)
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "global_position", global_position + direction, duration)
	await tween.finished
	queue_free()

func create_complex(text: String, res: FloatingTextResource) -> void:
	pass

func update_text(text: String, color: Color = Color.WHITE) -> void:
	text = text
	position = size/2
	modulate = color

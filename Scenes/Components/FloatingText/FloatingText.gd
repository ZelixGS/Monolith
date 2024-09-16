class_name FloatingText extends Label

func _ready() -> void:
	#top_level = true
	pivot_offset = size/2

func create_simple(value: Variant, duration: float = 1.5, color: Color = Color.WHITE) -> void:
	update_text(str(value), color)
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	print("[FCT] %s -> %s" % [position, position + Vector2(0, -250)])
	tween.tween_property(self, "position", position + Vector2(0, -250), duration)
	await tween.finished
	queue_free()

#func create_complex(string_text: String, res: FloatingTextResource) -> void:
	#pass

func update_text(string_text: String, color: Color = Color.WHITE) -> void:
	text = string_text
	modulate = color

extends Node

const FLOATINGTEXT: PackedScene = preload("res://Scenes/Components/FloatingText/FloatingText.tscn")

func simple_floating_text(text: Variant, position: Variant, duration: float, color: Color = Color.WHITE) -> void:
	var floater: FloatingText = FLOATINGTEXT.instantiate()
	if position is Node:
		position.add_child(floater)
	if position is Vector2 or position is Vector3:
		Global.get_master_scene().add_child(floater)
		floater.global_position = position
	floater.create_simple(text, duration, color)

extends Node

var master_scene: Node

const FLOATINGTEXT: PackedScene = preload("res://Scenes/Components/FloatingText/FloatingText.tscn")
func create_floating_text(text: String, position: Vector2, duration: float, direction: Vector2 = Vector2.UP, color: Color = Color.WHITE) -> void:
	var floater: FloatingText = FLOATINGTEXT.instantiate()
	get_master_scene().add_child(floater)
	floater.create_simple(text, duration, direction, color)
	floater.global_position = position

func get_master_scene() -> Node:
	if master_scene == null:
		master_scene = get_tree().get_first_node_in_group("player")
	return master_scene


func get_common_color(_color_name: String) -> Color:
	return Color.WHITE


func fade_in(node: Node, duration: float = 0.25, color: Color = Color.WHITE) -> void:
	if node.get("modulate") == null:
		return
	node.modulate = Color.TRANSPARENT
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(node, "modulate", color, duration)
	await tween.finished

func fade_out(node: Node, duration: float = 0.25) -> void:
	if node.get("modulate") == null:
		return
	var tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(node, "modulate", Color.TRANSPARENT, duration)
	await tween.finished

func digit_grouping(num: int, seperator: String = ",") -> String:
	var string: String = str(num)
	var mod: int = string.length() % 3
	var result: String = ""
	for i: int in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			result += seperator
		result += string[i]
	if num < 0:
		result = '-'+result
	return result

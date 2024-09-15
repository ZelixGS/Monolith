class_name Ghostly extends AnimationComponent
## [b]Ghostly[/b] is a basic animation that can be attached to Sprite2D, Sprite3D or any derivative.
## When attached and configured the sprite will be oscillate it's alpha.
## [br][br]
## This node is not intended to replace Animations or Animated sprites but used for quick and easy visual effects.

enum TYPE {
	SIN, ## Harsher hovering animation
	COS ## Softer hovering animation
}

@export var type: TYPE = TYPE.COS
@export var offset: float = 0.0 ## Placed nodes will be syncronized, you can use offset to desync.[br][br]Please use [b]Randomize[/b] for instanciated nodes.
@export_range(0, 100.0, 0.1) var frequency: float = 2.5
@export_range(0, 100.0, 0.1) var amplitude: float = 1
@export var reverse: bool = false ## Reverses animation. Down -> Up
@export var random: bool = false ## Randomizes [b]Offset[/b] between 0.1 to 2.0, forcing a desynronization. This should be used for instanciated nodes.

var time: float = 0

func _ready() -> void:
	if random:
		offset += randf_range(0.1, 2.0)
	time = offset

func _process(delta: float) -> void:
	if not enabled:
		return

	if reverse:
		time -= delta
	else:
		time += delta

	if type == TYPE.SIN:
		get_parent().self_modulate.a = sin(time * frequency) * amplitude
	if type == TYPE.COS:
		get_parent().self_modulate.a = cos(time * frequency) * amplitude

func _get_configuration_warnings() -> PackedStringArray:
	var isSprite2D: bool = get_parent() is Sprite2D
	var isSprite3D: bool = get_parent() is Sprite3D
	if isSprite2D or isSprite3D:
		return []
	return ["Attach to Sprite2D, Sprite3D or derivative."]

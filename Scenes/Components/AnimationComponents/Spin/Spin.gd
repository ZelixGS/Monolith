class_name Spin extends AnimationComponent
## [b]Spin[/b] is a basic animation that can be attached to Sprite2D, Sprite3D or any derivative.
## When attached and configured the sprite will be rotated to give the appreance of spinning.
## By default spinning sprites will rotate Clockwise.
## [br][br]
## This node is not intended to replace Animations or Animated sprites but used for quick and easy visual effects.

@export var speed: float = 0.025
@export var counter_clockwise: bool = false ## Will spin in the counter clockwise direction.
@export var offset: float = 0.0 ## Placed nodes will be syncronized, you can use offset to desync.[br][br]Please use [b]Randomize[/b] for instanciated nodes.
@export var random: bool = false ## Randomizes [b]Offset[/b] between 0.1 to 2.0, forcing a desynronization. This should be used for instanciated nodes.

func _ready() -> void:
	if random:
		offset += randf_range(0.1, 2.0)
	get_parent().rotation = offset

func _process(_delta: float) -> void:
	if not enabled:
		return

	if counter_clockwise:
		get_parent().rotation -= speed
	else:
		get_parent().rotation += speed

func _get_configuration_warnings() -> PackedStringArray:
	var isSprite2D: bool = get_parent() is Sprite2D
	var isSprite3D: bool = get_parent() is Sprite3D
	if isSprite2D or isSprite3D:
		return []
	return ["Attach to Sprite2D, Sprite3D or derivative."]

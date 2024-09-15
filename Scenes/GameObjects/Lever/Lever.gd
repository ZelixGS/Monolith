@tool
class_name Lever extends GameObject

enum STATE { OFF, ON }

@export var sticky: bool = false
var is_stuck: bool = false

@export_category("Sprite")
@export var off_color: Color = Color.CRIMSON
@export var on_color: Color = Color.DARK_GREEN
@export var stuck_color: Color = Color.DIM_GRAY
@export var off_sprite: Rect2 = Rect2(48, 160, 16, 16)
@export var on_sprite: Rect2 = Rect2(64, 160, 16, 16)

@onready var sprite_2d: ExtendedSprite2D = $ExtendedSprite2D
@onready var timer: Timer = $Timer

func _on_state_change() -> void:
	match state:
		STATE.OFF:
			sprite_2d.modulate = off_color
			sprite_2d.region_rect = off_sprite
		STATE.ON:
			sprite_2d.modulate = on_color
			sprite_2d.region_rect = on_sprite

func _on_interactable_interaction() -> void:
	if not timer.is_stopped():
		return
	if is_stuck:
		return
	if sticky and not is_stuck:
		is_stuck = true
	match state:
		STATE.OFF:
			state = STATE.ON
		STATE.ON:
			state = STATE.OFF
	if is_stuck:
		sprite_2d.transition_color(stuck_color)
	timer.start(0.25)

func reset() -> void:
	state = STATE.OFF
	is_stuck = false

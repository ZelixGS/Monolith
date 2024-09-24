@tool
class_name SlidingWall extends GameObject

enum STATE { CLOSED, OPEN }
enum DIRECTION { UP, DOWN, LEFT, RIGHT }

var animate: bool = false

@export var slide_distance: int = 16
@export var slide_direction: DIRECTION = DIRECTION.DOWN

@export_category("Sprite")
@export var tiles: Texture2D = preload("res://Assets/Sprites/GothicWalls.png"):
	set(value):
		tiles = value
		call_deferred("update_sprite")
@export var region: Vector2i = Vector2i.ZERO:
	set(value):
		region = value
		call_deferred("update_sprite")

@export_category("Animation")
@export var duration: float = 0.25
@export var transition: Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR
@export var easing: Tween.EaseType = Tween.EaseType.EASE_OUT

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var interactable_2d: Interactable2D = $Interactable2D
@onready var toggle_collision: ToggleCollision = $ToggleCollision

func update_sprite() -> void:
	sprite_2d.texture = tiles
	sprite_2d.region_rect = Rect2(region, Vector2(16,16))

func on_state_change() -> void:
	if state == STATE.OPEN:
		if animate:
			var tween: Tween = create_tween().set_trans(transition).set_ease(easing)
			tween.tween_property(sprite_2d, "global_position", sprite_2d.global_position + get_direction(), duration/2)
			tween.tween_property(sprite_2d, "modulate:a", 0, duration/2)
			print("Opening")
			await tween.finished
			print("Now Open")
			visible = false
		else:
			visible = false
		interactable_2d.disable()
		toggle_collision.disable()
	if state == STATE.CLOSED:
		if animate:
			visible = true
			var tween: Tween = create_tween().set_trans(transition).set_ease(easing)
			tween.tween_property(sprite_2d, "position", sprite_2d.position * (get_direction() * -1), duration)
			await tween.finished
		else:
			visible = true
		interactable_2d.enable()
		toggle_collision.enable()

func get_direction() -> Vector2:
	match slide_direction:
		DIRECTION.UP:
			return Vector2.UP * slide_distance
		DIRECTION.DOWN:
			return Vector2.DOWN * slide_distance
		DIRECTION.LEFT:
			return Vector2.LEFT * slide_distance
		DIRECTION.RIGHT:
			return Vector2.RIGHT * slide_distance
	return Vector2.ZERO

func _on_interactable_2d_interaction() -> void:
	if state == STATE.CLOSED:
		animate = true
		state = 1

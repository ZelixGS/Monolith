@icon("res://Scenes/GameObjects/Key/icon_key.png")
@tool
class_name Key extends GameObject
enum STATE { UNCOLLECTED, COLLECTED }

@export var key: Lock.TYPE = Lock.TYPE.YELLOW:
	set(value):
		key = value
		call_deferred("set_key_color")
@export var amount: int = 1

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player_detector_2d: PlayerDetector2D = $PlayerDetector2D

func set_key_color() -> void:
	sprite_2d.modulate = get_key_color(key)

func get_key_color(type: Lock.TYPE) -> Color:
	match type:
		Lock.TYPE.YELLOW:
			return Color(0.85, 0.75, 0.10)
		Lock.TYPE.BLUE:
			return Color(0.42, 0.66, 0.96)
		Lock.TYPE.RED:
			return Color(0.99, 0.30, 0.36)
		Lock.TYPE.SKULL:
			return Color(0.61, 0.59, 0.56)
		_:
			return Color(0.85, 0.75, 0.10)

func on_state_change() -> void:
	call_deferred("set_key_color")
	if state == STATE.COLLECTED:
		visible = false
		player_detector_2d.disable()
	if state == STATE.UNCOLLECTED:
		visible = true
		player_detector_2d.enable()

func _on_player_detector_entered() -> void:
	if state == STATE.UNCOLLECTED:
		Event.pickup_key.emit(key, amount)
		state = STATE.COLLECTED

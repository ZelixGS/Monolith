@tool
class_name Key extends GameObject

enum STATE { UNCOLLECTED, COLLECTED }

@export var key_name: String = "yellow"
@export var key_color: Color = Color(0.85, 0.75, 0.10):
	set(value):
		key_color = value
		if sprite_2d:
			sprite_2d.modulate = value

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player_detector: Area2D = $PlayerDetector

func _on_state_change() -> void:
	if sprite_2d:
		sprite_2d.modulate = key_color
	if state == STATE.COLLECTED:
		visible = false
		if player_detector:
			player_detector.set_deferred("monitoring", false)
	if state == STATE.UNCOLLECTED:
		visible = true
		if player_detector:
			player_detector.set_deferred("monitoring", true)

func _on_player_detector_entered() -> void:
	if state == STATE.UNCOLLECTED:
		GameManager.add_key(key_name)
		state = STATE.COLLECTED

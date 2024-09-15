class_name Potion extends GameObject

enum STATE { UNCOLLECTED, COLLECTED }

@export var amount: int = 200

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player_detector: Area2D = $PlayerDetector

func _on_state_change() -> void:
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
		GameManager.data.player_health += amount
		state = STATE.COLLECTED

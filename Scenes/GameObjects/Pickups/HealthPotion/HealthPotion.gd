class_name Potion extends GameObject

enum STATE { UNCOLLECTED, COLLECTED }

@export var amount: int = 200

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player_detector_2d: PlayerDetector2D = $PlayerDetector2D

func on_state_change() -> void:
	if state == STATE.COLLECTED:
		visible = false
		player_detector_2d.disable()
	if state == STATE.UNCOLLECTED:
		visible = true
		player_detector_2d.enable()

func _on_player_detector_entered() -> void:
	if state == STATE.UNCOLLECTED:
		Event.pickup_health.emit(amount)
		state = STATE.COLLECTED

class_name Monster extends GameObject

enum STATE { ALIVE, DEAD }

@export var stats: MonsterStats

@onready var sprite_2d: ExtendedSprite2D = $ExtendedSprite2D
@onready var player_detector: Area2D = $PlayerDetector
@onready var hover: Hover = $ExtendedSprite2D/Hover

func _on_ready() -> void:
	set_sprite()

func set_sprite() -> void:
	if sprite_2d:
		sprite_2d.texture = stats.sprite
		sprite_2d.modulate = stats.color
		hover.enabled = stats.hover

func _on_state_change() -> void:
	if state == STATE.ALIVE:
		visible = true
		if player_detector:
			player_detector.set_deferred("monitoring", true)
	if state == STATE.DEAD:
		visible = false
		if player_detector:
			player_detector.set_deferred("monitoring", false)

func _on_player_detector_entered() -> void:
	var result: bool = GameManager.start_combat(stats.to_stats())
	if result:
		state = STATE.DEAD

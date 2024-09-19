@tool
@icon("./icon_skull.png")
class_name Monster extends GameObject

enum STATE { ALIVE, DEAD }

@export var monster_stats: MonsterStats:
	set(value):
		monster_stats = value
		if monster_stats == null or monster_stats.name == "":
			name = "Monster"
		else:
			name = monster_stats.name
		call_deferred("set_sprite")

@onready var sprite_2d: ExtendedSprite2D = $ExtendedSprite2D
@onready var hover: Hover = $ExtendedSprite2D/Hover
@onready var player_detector_2d: PlayerDetector2D = $PlayerDetector2D

func _on_ready() -> void:
	set_sprite()

func _on_resource_changed() -> void:
	print("My resource just changed!")
	call_deferred("set_sprite")

func set_sprite() -> void:
	if monster_stats:
		sprite_2d.texture = monster_stats.sprite
		sprite_2d.modulate = monster_stats.color
		hover.enabled = monster_stats.hover

func on_state_change() -> void:
	if state == STATE.ALIVE:
		visible = true
		player_detector_2d.enable()
	if state == STATE.DEAD:
		visible = false
		player_detector_2d.disable()

func _on_player_detector_entered() -> void:
	var result: CombatResult = await GameManager.player_started_combat(monster_stats.to_stats())
	if result.victor == CombatResult.VICTOR.AGGRESSOR:
		state = STATE.DEAD

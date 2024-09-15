class_name GameResource extends Resource

@export var player_position: Vector2

@export var player_health: int = 1000:
	set(value):
		player_health = value
		Event.emit_signal("player_health", player_health)

@export var player_attack: int = 10:
	set(value):
		player_attack = value
		Event.emit_signal("player_attack", player_attack)

@export var player_defense: int = 5:
	set(value):
		player_defense = value
		Event.emit_signal("player_defense", player_defense)

@export var player_gold: int = 5:
	set(value):
		player_gold = value
		Event.emit_signal("player_gold", player_gold)

@export var keys: Dictionary = {}

@export var level_data: Dictionary = {}

func to_stats() -> Stats:
	return Stats.new(player_health, player_attack, player_defense)

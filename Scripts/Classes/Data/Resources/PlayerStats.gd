class_name PlayerStats extends Resource

@export var health: int = 1000:
	set(value):
		health = value
		Event.player_health.emit(health)

@export var attack: int = 100:
	set(value):
		attack = value
		Event.player_attack.emit(attack)

@export var defense: int = 100:
	set(value):
		defense = value
		Event.player_defense.emit(defense)

@export var gold: int = 0:
	set(value):
		gold = value
		Event.player_gold.emit(gold)

@export var position: Vector2 = Vector2.ZERO

@export var sprite: Texture2D = preload("res://Assets/Sprites/Monsters/Player.png")

func _init(_health: int = 1000, _attack: int = 100, _defense: int = 100, _gold: int = 0, _position: Vector2 = Vector2.ZERO, _sprite: Texture2D = sprite) -> void:
	health = _health
	attack = _attack
	defense = _defense
	gold = _gold
	position = _position

func to_stats() -> Stats:
	return Stats.new(health, attack, defense, gold, true, sprite)

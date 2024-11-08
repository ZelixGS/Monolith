class_name MonsterStats extends Resource

@export var name: String = ""
@export var health: int = 20
@export var attack: int = 20
@export var defense: int = 0
@export var gold: int = 10
@export var sprite: Texture2D
@export var color: Color = Color.WHITE_SMOKE
@export var hover: bool = false

func to_stats() -> Stats:
	return Stats.new(health, attack, defense, gold, false, sprite, color)

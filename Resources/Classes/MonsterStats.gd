class_name MonsterStats extends Resource

@export var monster_name: String = ""
@export var health: int = 20
@export var attack: int = 20
@export var defense: int = 0
@export var gold: int = 10
@export var sprite: Texture2D:
	set(value):
		sprite = value
		changed.emit()

@export var color: Color = Color.WHITE_SMOKE:
	set(value):
		color = value
		changed.emit()

@export var hover: bool = false:
	set(value):
		hover = value
		changed.emit()

func to_stats() -> Stats:
	return Stats.new(health, attack, defense, gold, false, sprite)

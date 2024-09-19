extends PanelContainer

@onready var health: ExtendedLabel = %Health
@onready var attack: ExtendedLabel = %Attack
@onready var defense: ExtendedLabel = %Defense
@onready var gold: ExtendedLabel = %Gold


func _ready() -> void:
	Event.connect("player_health", update_health)
	Event.connect("player_attack", update_attack)
	Event.connect("player_defense", update_defense)
	Event.connect("player_gold", update_gold)

func update_health(value: int) -> void:
	health.number = value

func update_attack(value: int) -> void:
	attack.number = value

func update_defense(value: int) -> void:
	defense.number = value

func update_gold(value: int) -> void:
	gold.number = value

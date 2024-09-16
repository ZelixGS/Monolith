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

func update_health(value: int, use_animation: bool = true) -> void:
	health.update_text(value, use_animation)

func update_attack(value: int, use_animation: bool = true) -> void:
	attack.update_text(value, use_animation)

func update_defense(value: int, use_animation: bool = true) -> void:
	defense.update_text(value, use_animation)

func update_gold(value: int, use_animation: bool = true) -> void:
	gold.update_text(value, use_animation)

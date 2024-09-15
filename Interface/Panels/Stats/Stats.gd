extends PanelContainer

@export var health_float: Node2D
@export var attack_float: Node2D
@export var defense_float: Node2D
@export var gold_float: Node2D


@onready var health_label: Label = $MarginContainer/AspectRatioContainer/Stats/Health/HealthLabel
@onready var attack_label: Label = $MarginContainer/AspectRatioContainer/Stats/Attack/AttackLabel
@onready var defense_label: Label = $MarginContainer/AspectRatioContainer/Stats/Defense/DefenseLabel
@onready var gold_label: Label = $MarginContainer/AspectRatioContainer/Stats/Gold/GoldLabel

func _ready() -> void:
	Event.connect("player_health", update_health)
	Event.connect("player_attack", update_attack)
	Event.connect("player_defense", update_defense)
	Event.connect("player_gold", update_gold)
	update_health(GameManager.data.player_health)
	update_attack(GameManager.data.player_attack)
	update_defense(GameManager.data.player_defense)
	update_gold(GameManager.data.player_gold)


func update_health(value: int) -> void:
	Global.create_floating_text(str("HI"), health_float.global_position, 1.0, Vector2(0, -5))
	health_label.text = Global.digit_grouping(value)

func update_attack(value: int) -> void:
	attack_label.text = Global.digit_grouping(value)

func update_defense(value: int) -> void:
	defense_label.text = Global.digit_grouping(value)

func update_gold(value: int) -> void:
	gold_label.text = Global.digit_grouping(value)

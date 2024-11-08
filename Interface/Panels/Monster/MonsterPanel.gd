extends PanelContainer

@onready var texture_rect: TextureRect = %TextureRect
@onready var health: ExtendedLabel = %Health
@onready var attack: ExtendedLabel = %Attack
@onready var defense: ExtendedLabel = %Defense

func _ready() -> void:
	Event.ui_mouseover_monster.connect(update)


func update(monster: Stats) -> void:
	texture_rect.texture = monster.texture
	texture_rect.self_modulate = monster.color
	health.number = monster.health
	attack.number = monster.attack
	defense.number = monster.defense

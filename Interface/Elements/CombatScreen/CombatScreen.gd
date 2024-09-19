class_name CombatScreen extends CenterContainer

@onready var attacker_sprite: TextureRect = %AttackerSprite
@onready var defender_sprite: TextureRect = %DefenderSprite
@onready var accept: Button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/Accept
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var attacker_health: ExtendedLabel = %AttackerHealth
@onready var attacker_attack: ExtendedLabel = %AttackerAttack
@onready var attacker_defense: ExtendedLabel = %AttackerDefense

@onready var defender_health: ExtendedLabel = %DefenderHealth
@onready var defender_attack: ExtendedLabel = %DefenderAttack
@onready var defender_defense: ExtendedLabel = %DefenderDefense

func _ready() -> void:
	Event.ui_combat_setup_stage.connect(setup)
	Event.ui_combat_attacker_defeated.connect(attacker_defeated)
	Event.ui_combat_attacker_animation.connect(attacker_animation)
	Event.ui_combat_attacker_take_damage.connect(attacker_health_text)

	Event.ui_combat_defender_defeated.connect(defender_defeated)
	Event.ui_combat_defender_animation.connect(defender_animation)
	Event.ui_combat_defender_take_damage.connect(defender_health_text)

	Event.ui_combat_complete.connect(enable_accept)

	reset()

func setup(attacker: Stats, defender: Stats) -> void:
	attacker_sprite.texture = attacker.texture
	attacker_health.number = attacker.health
	attacker_attack.number = attacker.attack
	attacker_defense.number = attacker.defense
	attacker_sprite.self_modulate.a = 1

	defender_sprite.texture = defender.texture
	defender_health.number = defender.health
	defender_attack.number = defender.attack
	defender_defense.number = defender.defense
	defender_sprite.self_modulate.a = 1

func reset() -> void:
	accept.disabled = true
	animation_player.play("RESET")
	set_pivot()

func set_pivot() -> void:
	Global.control_set_pivot_bottom(attacker_sprite)
	Global.control_set_pivot_bottom(defender_sprite)

func attacker_animation() -> void:
	animation_player.play("left_attack")

func attacker_health_text(amount: int) -> void:
	attacker_health.number = amount

func attacker_defeated() -> void:
	animation_player.play("left_death")

func defender_animation() -> void:
	animation_player.play("right_attack")

func defender_health_text(amount: int) -> void:
	defender_health.number = amount

func defender_defeated() -> void:
	animation_player.play("right_death")

func animation_finished() -> void:
	Event.ui_combat_animation_complete.emit()

func enable_accept() -> void:
	accept.disabled = false

func _on_accept_button_up() -> void:
	Event.ui_combat_window_hide.emit()

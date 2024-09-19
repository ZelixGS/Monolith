class_name CombatScreen extends CenterContainer

@onready var attacker_sprite: TextureRect = %AttackerSprite
@onready var defender_sprite: TextureRect = %DefenderSprite
@onready var accept: Button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/Accept
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var attacker_health: IconLabel = %AttackerHealth
@onready var attacker_attack: IconLabel = %AttackerAttack
@onready var attacker_defense: IconLabel = %AttackerDefense

@onready var defender_health: IconLabel = %DefenderHealth
@onready var defender_attack: IconLabel = %DefenderAttack
@onready var defender_defense: IconLabel = %DefenderDefense

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
	attacker_health.set_label(attacker.health)
	attacker_attack.set_label(attacker.attack)
	attacker_defense.set_label(attacker.defense)
	attacker_sprite.self_modulate.a = 1

	defender_sprite.texture = defender.texture
	defender_health.set_label(defender.health)
	defender_attack.set_label(defender.attack)
	defender_defense.set_label(defender.defense)
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
	attacker_health.set_label(amount)

func attacker_defeated() -> void:
	animation_player.play("left_death")

func defender_animation() -> void:
	animation_player.play("right_attack")

func defender_health_text(amount: int) -> void:
	defender_health.set_label(amount)

func defender_defeated() -> void:
	animation_player.play("right_death")

func animation_finished() -> void:
	Event.ui_combat_animation_complete.emit()

func enable_accept() -> void:
	accept.disabled = false

func _on_accept_button_up() -> void:
	Event.ui_combat_window_hide.emit()

class_name CombatManager extends Node

var use_fast_combat: bool = false
var slow_combat_base_speed: float = 2

func _init() -> void:
	pass

func start_combat(attacker: Stats, defender: Stats) -> CombatResult:
	var result: CombatResult
	if use_fast_combat:
		result = fast_combat(attacker, defender)
	else:
		result = await slow_combat(attacker, defender)
	return result

func slow_combat(attacker: Stats, defender: Stats) -> CombatResult:
	var result: CombatResult
	Event.ui_combat_setup_stage.emit(attacker, defender)
	var attacker_damage: int = maxi(1, attacker.attack - defender.defense)
	var defender_damage: int = maxi(1, defender.attack - attacker.defense)

	var aggressor_damage_taken: int = 0
	Event.ui_combat_window_show.emit()
	await Event.ui_combat_window_opened
	while defender.health > 0:
		Event.ui_combat_start.emit()
		# Attacker
		Event.ui_combat_attacker_animation.emit()
		await Event.ui_combat_animation_complete
		defender.health -= attacker_damage
		Event.ui_combat_defender_take_damage.emit(defender.health)
		if defender.health <= 0:
			Event.ui_combat_defender_defeated.emit()
			await Event.ui_combat_animation_complete
			Event.ui_combat_complete.emit()
			result = CombatResult.new(CombatResult.VICTOR.AGGRESSOR, aggressor_damage_taken)
			break

		# Defender
		Event.ui_combat_defender_animation.emit()
		await Event.ui_combat_animation_complete
		attacker.health -= defender_damage
		Event.ui_combat_attacker_take_damage.emit(attacker.health)
		aggressor_damage_taken += defender_damage
		if attacker.health <= 0:
			Event.ui_combat_attacker_defeated.emit()
			await Event.ui_combat_animation_complete
			Event.ui_combat_complete.emit()
			result = CombatResult.new(CombatResult.VICTOR.DEFENDER, aggressor_damage_taken)
			break

		#await get_tree().create_timer(slow_combat_base_speed).timeout
	await Event.ui_combat_window_closed
	return result

func fast_combat(_attacker: Stats, _defender: Stats) -> CombatResult:
	return CombatResult.new(CombatResult.VICTOR.AGGRESSOR, 0)


#func start_combat(monster: Stats) -> bool:
	#var result: int = combat(data.to_stats(), monster)
	#if result != -1:
		#data.player_health -= result
		#data.player_gold += monster.gold
		#return true
	#Event.emit_signal("game_over")
	#return false
#
#func combat(attacker: Stats, defender: Stats) -> int:
	#if use_fast_combat:
		#return fast_combat(attacker, defender)
	#return slow_combat(attacker, defender)
#
#func slow_combat(_attacker: Stats, _defender: Stats) -> int:
	#return 0
#
#func fast_combat(attacker: Stats, defender: Stats) -> int:
	#var attacker_damage: int = maxi(attacker.attack - defender.defense, 0)
	#var defender_damage: int = maxi(defender.attack - attacker.defense, 0)
#
	#@warning_ignore("integer_division")
	#var attacker_turns: int = ceili(defender.health / attacker_damage)
	#@warning_ignore("integer_division")
	#var defender_turns: int = ceili(attacker.health / defender_damage)
#
	#if attacker_turns <= defender_turns:
		#Event.combat_attacker_victory.emit()
		#return (attacker_turns - 1) * defender_damage
	#else:
		#Event.combat_defender_victory.emit()
		#return -1

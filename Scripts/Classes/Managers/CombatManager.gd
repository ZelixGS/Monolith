class_name CombatManager extends Object
#
##region Combat
#
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
#
##endregion

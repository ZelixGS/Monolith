extends Node

const PLAYER_SCENE: PackedScene = preload("res://Scenes/Player/Player.tscn")

var game_name: String = "Zelix"
var data: GameResource

var player: Player
var current_level: Level

var use_fast_combat: bool = true

func _ready() -> void:
	data = load_game()
	initialize_level()
	initialize_player()
	call_deferred("load_current_level")

#region Save/Load
func load_game() -> GameResource:
	if ResourceLoader.exists("res://%s.tres" % game_name):
		return load("res://%s.tres" % game_name)
	else:
		return GameResource.new()

func save_game() -> void:
	save_player()
	save_current_level()
	ResourceSaver.save(data, "res://%s.tres" % game_name)

func save_player() -> void:
	if player:
		data.player_position = player.global_position

func save_current_level() -> void:
	var dict: Dictionary = {}
	for i: Node in current_level.objects.get_children():
		if i is GameObject:
			dict[i.name] = i.state
	data.level_data[current_level.name] = dict

func load_current_level() -> void:
	if not data.level_data.has(current_level.name):
		return
	var level_data: Dictionary = data.level_data.get(current_level.name)
	if level_data == null:
		return
	for i: Node in current_level.objects.get_children():
		if level_data.has(i.name):
			i.state = level_data[i.name]
#endregion


#region Initializers
func initialize_player() -> void:
	player = get_tree().get_first_node_in_group("player")
	if player == null:
		player = PLAYER_SCENE.instantiate()
		current_level.add_child(player)
	if player:
		player.global_position = data.player_position
		if player.global_position == Vector2(0, 0):
			player.global_position = current_level.entrace_below.global_position
		update_player_stats()

func initialize_level() -> void:
	current_level = get_tree().get_first_node_in_group("level")
	if current_level == null:
		printerr("Could not find Level")
		assert(current_level != null)
#endregion



func update_player_stats() -> void:
	Event.player_health.emit(data.player_health)
	Event.player_attack.emit(data.player_attack)
	Event.player_defense.emit(data.player_defense)
	Event.player_gold.emit(data.player_gold)

#region Key
func has_key(key_name: String) -> bool:
	return data.keys.has(key_name)

func add_key(key_name: String) -> void:
	if has_key(key_name):
		data.keys[key_name] += 1
	else:
		data.keys[key_name] = 1

func remove_key(key_name: String) -> void:
	if data.keys[key_name] > 1:
		data.keys[key_name] -= 1
	else:
		data.keys.erase(key_name)
#endregion

#region Combat

func start_combat(monster: Stats) -> bool:
	var result: int = combat(data.to_stats(), monster)
	if result != -1:
		data.player_health -= result
		data.player_gold += monster.gold
		return true
	return false

func combat(attacker: Stats, defender: Stats) -> int:
	if use_fast_combat:
		return fast_combat(attacker, defender)
	return slow_combat(attacker, defender)

func slow_combat(attacker: Stats, defender: Stats) -> int:
	return 0

func fast_combat(attacker: Stats, defender: Stats) -> int:
	var attacker_damage: int = maxi(attacker.attack - defender.defense, 0)
	var defender_damage: int = maxi(defender.attack - attacker.defense, 0)

	var attacker_turns: int = ceil(defender.health / attacker_damage)
	var defender_turns: int = ceil(attacker.health / defender_damage)

	if attacker_turns <= defender_turns:
		Event.combat_attacker_victory.emit()
		return (attacker_turns - 1) * defender_damage
	else:
		Event.combat_defender_victory.emit()
		return -1
	return -1

#endregion

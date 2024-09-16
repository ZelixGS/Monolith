extends Node

const PLAYER_SCENE: PackedScene = preload("res://Scenes/Player/Player.tscn")

var game_name: String = "Zelix"

var player: PlayerStats
var level: Level

var current_player: Player
var current_level: LevelNode

var save_manager: SaveManager = SaveManager.new(game_name)
var combat_manager: CombatManager = CombatManager.new()

func _ready() -> void:
	Event.pickup_health.connect(player_health)
	#Event.pickup_attack.connect()
	#Event.pickup_defense.connect()
	#Event.pickup_gold.connect()
	#Event.pickup_key.connect()
	Event.object_state_changed.connect(gameobject_state)
	Event.ui_quit_game.connect(quit_game)

	current_player = get_player()
	current_level = get_level()

	player = save_manager.load_player()
	if current_level:
		level = save_manager.load_level(current_level.name)

	initialize_level()
	initialize_player()

#region Initializers

func get_level() -> LevelNode:
	var _level: LevelNode = get_tree().get_first_node_in_group("level")
	if not _level:
		printerr("[GameManager] Could not find [Level]")
	return _level

func get_player() -> Player:
	var _player: Player = get_tree().get_first_node_in_group("player")
	if not _player:
		printerr("[GameManager] Could not find [Player]")
	return _player

func initalize() -> void:
	initialize_level()
	initialize_player()
	initialize_camera()

func initialize_level() -> void:
	if level == null:
		print("[GameManager] Could not find [Level Data] to load")
		return
	for child: GameObject in current_level.objects.get_children():
		if level.objects.has(child.name):
			child.state = level.objects[child.name]

func initialize_player() -> void:
	if current_player == null:
		current_player = PLAYER_SCENE.instantiate()
		current_level.add_child(current_player)
	current_player.global_position = player.position
	if current_player.global_position == Vector2(0, 0):
		current_player.global_position = current_level.entrance_from_below.global_position
	call_deferred("update_player_stats")

func update_player_stats() -> void:
	Event.player_health.emit(player.health)
	Event.player_attack.emit(player.attack)
	Event.player_defense.emit(player.defense)
	Event.player_gold.emit(player.gold)

func initialize_camera() -> void:
	pass
#endregion

#region Quitting

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		quit_game()

func quit_game(bypass_saving: bool = false) -> void:
	print("Quitting!")
	save_manager.save_player(player)
	get_tree().quit()

#endregion

func gameobject_state(obj_name: String, state: int) -> void:
	if level:
		level.objects[obj_name] = state
		return
	printerr("[GameManager] No Level Data to save to.")

func player_health(amount: int) -> void:
	player.health += amount



##region Key
#func has_key(key_name: String) -> bool:
	#return data.keys.has(key_name)
#
#func add_key(key_name: String) -> void:
	#if has_key(key_name):
		#data.keys[key_name] += 1
	#else:
		#data.keys[key_name] = 1
#
#func remove_key(key_name: String) -> void:
	#if data.keys[key_name] > 1:
		#data.keys[key_name] -= 1
	#else:
		#data.keys.erase(key_name)
##endregion

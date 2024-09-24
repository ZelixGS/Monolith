extends Node

const PLAYER_SCENE: PackedScene = preload("res://Scenes/Player/Player.tscn")

signal ready_for_initialization(tile_map_layer: LevelNode)
signal request_transition(direction: String)

var game_name: String = "Zelix"

var player: PlayerStats
var inventory: Inventory
var level: Level

var current_player: Player
var current_level: LevelNode

var save_manager: SaveManager = SaveManager.new(game_name)
var combat_manager: CombatManager = CombatManager.new()

func _ready() -> void:
	connect_signals()
	load_save_file()

func connect_signals() -> void:
	Event.pickup_health.connect(pickup_health)
	Event.pickup_attack.connect(pickup_attack)
	Event.pickup_defense.connect(pickup_defense)
	Event.pickup_gold.connect(pickup_gold)
	Event.pickup_key.connect(pickup_key)
	Event.player_position.connect(player_position)
	Event.object_state_changed.connect(gameobject_state)
	Event.ui_quit_game.connect(quit_game)
	ready_for_initialization.connect(initalize)

func load_save_file() -> void:
	player = save_manager.load_player()
	inventory = save_manager.load_inventory()

#region Initializers
func initalize(map: LevelNode) -> void:
	current_level = map
	level = save_manager.load_level(current_level.name)

	initialize_level()
	initialize_player()
	initialize_camera()

func initialize_level() -> void:
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
	current_player.sprite_2d.texture = player.sprite
	call_deferred("update_player_stats")

func initialize_camera() -> void:
	pass
#endregion

#region Quitting

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		quit_game()

func quit_game(save_game: bool = true) -> void:
	print("Quitting!")
	if save_game:
		save_manager.save_game()
	get_tree().quit()

#endregion

func update_player_stats() -> void:
	Event.player_health.emit(player.health)
	Event.player_attack.emit(player.attack)
	Event.player_defense.emit(player.defense)
	Event.player_gold.emit(player.gold)

func gameobject_state(obj_name: String, state: int) -> void:
	if level:
		level.objects[obj_name] = state
		return
	printerr("[GameManager] No Level Data to save to.")

func pickup_health(amount: int) -> void:
	player.health += amount

func pickup_attack(amount: int) -> void:
	player.attack += amount

func pickup_defense(amount: int) -> void:
	player.defense += amount

func pickup_gold(amount: int) -> void:
	player.gold += amount

func pickup_key(key: Lock.TYPE, amount: int) -> void:
	inventory.add_key(key, amount)

func player_position(position: Vector2) -> void:
	player.position = position

func player_started_combat(monster: Stats) -> CombatResult:
	var result: CombatResult = await combat_manager.start_combat(player.to_stats(), monster)
	if result.victor == CombatResult.VICTOR.AGGRESSOR:
		#await Event.ui_combat_window_closed
		player.health -= result.damage_taken
	if result.victor == CombatResult.VICTOR.DEFENDER:
		#await Event.ui_combat_window_closed
		Event.game_over.emit()
	return result

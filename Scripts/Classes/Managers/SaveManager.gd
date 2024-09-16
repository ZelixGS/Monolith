class_name SaveManager extends Object

const FILE_PATH: StringName = "res://"
const FILE_NAME: StringName = "Default"
const EXTENSION: StringName = "tres"

var file_name: String = FILE_NAME
var save_file: SaveFile

func _init(save_name: String = FILE_NAME) -> void:
	file_name = save_name
	save_file = load_save_file()

func get_file_name() -> String:
	return "%s%s.%s" % [FILE_PATH, file_name, EXTENSION]

func load_save_file() -> SaveFile:
	if ResourceLoader.exists(get_file_name()):
		return load(get_file_name())
	else:
		printerr("[SaveManager] Could not find save: %s" % get_file_name())
		var new: SaveFile = SaveFile.new()
		new.player = PlayerStats.new()
		return new

func save_to_disk(save_message: String = "") -> void:
	if save_message != "":
		print("[SaveManager] %s" % save_message)
		print(get_file_name())
	ResourceSaver.save(save_file, get_file_name())

func save_game(player: PlayerStats, level: Level) -> void:
	save_player(player)
	save_level(level)

func save_player(player: PlayerStats) -> void:
	save_file.player = player
	save_to_disk("Saving Player...")

func save_level(level: Level) -> void:
	save_file.level[level.name] = level
	save_to_disk("Saving Level: %s..." % level.name)

func load_player() -> PlayerStats:
	return save_file.player

func load_level(name: String) -> Level:
	if save_file.level.has(name):
		return save_file.level[name]
	else:
		printerr("[SaveManager] Save File does not contain Level data for %s" % name)
		var level: Level = Level.new()
		save_file.level[name] = level
		return save_file.level[name]

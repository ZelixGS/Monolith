@icon("./icon_gear.png")
extends Node

const FILE_PATH: StringName = "res://"
const FILE_NAME: StringName = "Settings"
const EXTENSION: StringName = "ini"

signal apply_settings
signal setting_changed(setting_name: String, value: Variant)
signal text_scale_changed

var world: WorldEnvironment
var camera: Camera2D

var settings: Dictionary = {
	"camera_shake_strength": preload("res://Scripts/Global/Configuration/Settings/CameraShakeStrength.tres"),
	"floating_combat_text": preload("res://Scripts/Global/Configuration/Settings/FloatingCombatText.tres"),
	"master_audio": preload("res://Scripts/Global/Configuration/Settings/MasterVolume.tres"),
	#"ui_scale": {
		#"section": "interface",
		#"value": 1.0,
		#"default": 1.0,
		#"min": 1.0,
		#"max": 4.0,
		#"rounded": true,
		#"step": 1,
	#},
	#"text_scale": {
		#"section": "interface",
		#"value": 1.0,
		#"default": 1.0,
		#"min": 0.0,
		#"max": 1.0,
		#"rounded": false,
		#"step": 0.1,
	#},
	#"master_volume": {
		#"section": "audio",
		#"value": 0.75,
		#"default": 0.75,
		#"type": "Slider",
		#"min": 0.0,
		#"max": 1.0,
		#"rounded": false,
		#"step": 0.1,
	#},
	#"sound_volume": {
		#"section": "audio",
		#"value": 0.75,
		#"default": 0.75,
		#"type": "Slider",
		#"min": 0.0,
		#"max": 1.0,
		#"rounded": false,
		#"step": 0.1,
	#},
	#"music_volume": {
		#"section": "audio",
		#"value": 0.75,
		#"default": 0.75,
		#"type": "Slider",
		#"min": 0.0,
		#"max": 1.0,
		#"rounded": false,
		#"step": 0.1,
	#},
	#"player_footsteps_volume": {
		#"section": "audio",
		#"value": 0.1,
		#"default": 0.75,
		#"type": "Slider",
		#"min": 0.0,
		#"max": 1.0,
		#"rounded": false,
		#"step": 0.1,
	#},
}

func _ready() -> void:
	setting_changed.connect(change_setting)
	apply_settings.connect(save_config)
	load_config()

#region File Creating/Saving/Loading
func get_file_name() -> String:
	return "%s%s.%s" % [FILE_PATH, FILE_NAME, EXTENSION]

func load_config() -> void:
	if not FileAccess.file_exists(get_file_name()):
		create_config()
	else:
		parse_config()

func create_config() -> void:
	var file: ConfigFile = ConfigFile.new()
	for key: String in settings:
		var setting: Setting = get_setting(key)
		if setting.hidden:
			continue
		file.set_value(setting.section, key, setting.default)
	file.save(get_file_name())

func parse_config() -> void:
	var need_to_save: bool = false

	var file: ConfigFile = ConfigFile.new()
	var error_status: Error = file.load(get_file_name())
	if error_status != OK:
		printerr("[%s] Failed to Load Configuration: %s" % [error_status, get_file_name()])
		return

	for key: String in settings:
		var setting: Setting = get_setting(key)
		if file.has_section_key(setting.section, key):
			setting.value = file.get_value(setting.section, key)
		else:
			if setting.hidden:
				continue
			need_to_save = true
			file.set_value(setting.section, key, setting.default)

	if need_to_save:
		file.save(get_file_name())

func save_config() -> void:
	var file: ConfigFile = ConfigFile.new()
	var error_status: Error = file.load(get_file_name())
	if error_status != OK:
		printerr("[%s] Failed to Load Configuration: %s" % [error_status, get_file_name()])
		return

	for key: String in settings:
		var setting: Setting = get_setting(key)
		if setting.hidden:
			continue
		file.set_value(setting.section, key, setting.value)
	file.save(get_file_name())
#endregion

#region Getters
func get_setting(key: String) -> Setting:
	if not settings.has(key):
		return null
	return settings[key]

func get_value(key: String, default: Variant = null) -> Variant:
	if not settings.has(key):
		return default
	var setting: Setting = get_setting(key)
	return setting.value
#endregion

func change_setting(key: String, value: Variant) -> void:
	if not settings.has(key):
		return
	var setting: Setting = get_setting(key)
	setting.value = value

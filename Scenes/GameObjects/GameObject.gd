@icon("res://Scenes/GameObjects/icon_gear.png")
class_name GameObject extends Node2D

signal update(gameobj: GameObject)

var last_state: int = 0

@export var state: int = 0 :
	set(value):
		last_state = state
		state = value
		update.emit(self)
		call_deferred("on_state_change")
		if not Engine.is_editor_hint():
			Event.object_state_changed.emit(name, state)

func _ready() -> void:
	on_ready()

func on_ready() -> void:
	pass

func on_state_change() -> void:
	pass

func reset() -> void:
	pass

func on_player_detector_entered() -> void:
	pass

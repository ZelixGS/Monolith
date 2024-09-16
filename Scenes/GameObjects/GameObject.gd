@icon("res://Scenes/GameObjects/icon_gear.png")
class_name GameObject extends Node2D

signal update(gameobj: GameObject)

var last_state: int = 0

@export var state: int = 0 :
	set(value):
		last_state = state
		state = value
		update.emit(self)
		_on_state_change()
		Event.object_state_changed.emit(name, state)

func _ready() -> void:
	_on_state_change()
	_on_ready()

func _on_ready() -> void:
	pass

func _on_state_change() -> void:
	pass

func reset() -> void:
	pass


func _on_player_detector_entered() -> void:
	pass # Replace with function body.

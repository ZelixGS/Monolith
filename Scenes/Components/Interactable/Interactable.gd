class_name Interactable2D extends Area2D

signal interaction

@export var interaction_node: Node
@export var interaction_method: StringName = "on_interaction"
@export var interaction_signal: bool = true

func enable() -> void:
	set_deferred("monitoring", true)

func disable() -> void:
	set_deferred("monitoring", false)

func toggle() -> void:
	set_deferred("monitoring", !monitoring)

func interact() -> void:
	if interaction_signal:
		interaction.emit()
	if interaction_node:
		if interaction_node.has_method(interaction_method):
			interaction_node.call(interaction_method)
		else:
			printerr("[Interactable] %s.%s is missing '%s' Method." % [interaction_node.owner.name, interaction_node.name, interaction_method])

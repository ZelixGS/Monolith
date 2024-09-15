class_name Conditional extends Node

signal activate
signal deactivate

@export var auto_check: bool = true
@export var sequence: bool = true
var compare_sequence: String = ""
var input_sequence: String = ""

@export var property: String = "state"
@export var conditions: Array[String] = []

## The method the Conditional will attempt to call on it's parent if used as a external component.
## This method will only be called if all conditions are true.
## Setting the value to an empty string will skip the attempted method call to parent.[br][br]
## [b]Note:[/b] If the method cannot be found on the parent it will fail gracefully and print an error message.
@export var success_method: String = "on_success"
## The method the Conditional will attempt to call on it's parent if used as a external component.
## This method will only be called if any conditions are false.
## Setting the value to an empty string will skip the attempted method call to parent.[br][br]
## [b]Note:[/b] If the method cannot be found on the parent it will fail gracefully and print an error message.
@export var failure_method: String = "on_failure"

func _ready() -> void:
	for child: Node in get_children():
		compare_sequence += child.name
		if child is GameObject:
			child.update.connect(on_update)

func on_update(Obj: GameObject) -> void:
	if conditions.size() != get_child_count():
		printerr("%s.%s is missing matching conditions for children. [%s/%s]" % [get_parent().name, name, conditions.size(), get_child_count()])
		return
	var count: int = 0
	input_sequence += Obj.name
	for i: int in get_children().size():
		var value: String = str(get_child(i).get(property))
		if value == conditions[i]:
			count += 1
	if count == conditions.size():
		if sequence and input_sequence != compare_sequence:
			failure()
			reset()
			return
		success()
	else:
		failure()

func success() -> void:
	activate.emit()
	attempt_call_method(success_method)

func failure() -> void:
	deactivate.emit()
	attempt_call_method(failure_method)

func reset() -> void:
	for child: Node in get_children():
		if child is GameObject:
			child.reset()
	input_sequence = ""

func attempt_call_method(method: String) -> void:
	if method != "":
		var parent: Node = get_parent()
		if parent.has_method(method):
			parent.call(method)
		else:
			printerr("%s does not have a method for %s" % [parent.name, method])

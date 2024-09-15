@icon("res://Scenes/Components/FlagComponent/Internal/FlagReceiver.png")
class_name FlagReceiver extends Node
## [b]FlagReceiver[/b] is a listener for a [code]flag[/code] signal on the Signal/Event Bus then emits a signal and attempts to call a named method on its parent.
## FlagReceiver(s) will ignore any signals that has empty strings for it's flag or values property.[br][br]
## This node can be used as both an internal and external component.[br][br]
## [b]Note:[/b] This node does not do any logical or conditional checking and should be handled by its parent node, or signal receiver.

## Emitted when a flag is recieved with the correct flag identifier and a value that isn't an empty string.
signal flagged(received_flag: Flag)

## The name of a flag that this FlagReceivers will listen for. If left blank this [b]FlagReceiver[/b] will never be triggered.
@export var flag: String = ""

## The method the FlagReceiver will attempt to call on it's parent if used as a external component.
## Setting the value to an empty string will skip the attempted method call to parent.[br][br]
## [b]Note:[/b] If the method cannot be found on the parent it will fail gracefully and print an error message.
@export var call_method: String = "on_flagged"
## If the flag receiver should pass the flag to the call method. Turning it off is useful if you want a parent object to not care about the value.
@export var include_flag: bool = true

func _ready() -> void:
	Event.connect("flag", _on_recieved_flag)
	if flag == "":
		printerr("%s.%s is missing a flag identifier and will never be triggered." % [owner.name, name])


func _on_recieved_flag(res: Flag) -> void:
	if res.name == "" or res.value == "":
		if res.value == "":
			printerr("Flag %s was received but did not contain a value" % res.name)
		return
	if res.name != flag:
		return

	flagged.emit(res)

	if call_method != "":
		var parent: Node = get_parent()
		if parent.has_method(call_method):
			if include_flag:
				parent.call(call_method, res)
			else:
				parent.call(call_method)
		else:
			printerr("%s does not have a method for %s" % [parent.name, call_method])

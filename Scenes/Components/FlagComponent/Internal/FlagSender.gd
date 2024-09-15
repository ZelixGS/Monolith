@icon("res://Scenes/Components/FlagComponent/Internal/FlagSender.png")
class_name FlagSender extends Node

## A flag sender component can be added to any other node and be called to send signals through the Signal/Event Bus to be picked up by Flag Receivers.
## A single sender cannot send more than one flag at a time, but multiple FlagSender components can be used if multiple flags being sent is desired.

## The string name of a flag indentifier that FlagReceivers will listen to.
@export var flag: String = ""

## The string conditional the flag will pass. Without Use Property enabled this is a custom value that will be passed with the flag.
## With Use Property enabled this becomes the property name that the FlagSender will search it's parent for the property and send it's current value. If the property isn't found for any reason a blank string will be sent instead.
@export var value: String = ""

## When enabled, the flag sender will check the parent for a property with Value's name.
## If the property isn't found for any reason a blank string will be return and cause flag receivers to silently ignore it.
@export var use_property: bool = true


## The only method that can should be called. The method itself handles the logic of dealing with getting parent's properties.
## If Use Property is enabled the node will always search it's parent for the property and if it cannot be found will default to an empty string.
func send_flag() -> void:
	var new_value: String = value
	if use_property:
		var parent: Node = get_parent()
		var temp: String = str(parent.get(value))
		if temp != "":
			new_value = temp
		else:
			new_value = ""
	var parent_name: String = "%s.%s" % [get_parent().name, name]
	Event.emit_signal("flag", Flag.new(flag, new_value, parent_name))

class_name Flag extends Object

var name: String = ""
var value: String = ""
var sender: String = ""

func _init(n: String, v: String, s: String) -> void:
	name = n
	value = v
	sender = s

func _to_string() -> String:
	return("Sender: [%s], Flag: [%s], Value: [%s]" % [sender, name, value])

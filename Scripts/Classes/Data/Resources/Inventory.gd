class_name Inventory extends Resource

@export var keys: Dictionary = {
	Lock.TYPE.YELLOW: 0,
	Lock.TYPE.BLUE: 0,
	Lock.TYPE.RED: 0,
	Lock.TYPE.SKULL: 0,
}

func _init() -> void:
	pass

func has_key(key: Lock.TYPE) -> bool:
	return keys.get(key) > 0

func add_key(key: Lock.TYPE, amount: int = 1) -> void:
	keys[key] += amount
	Event.ui_key.emit(key, keys[key])

func use_key(key: Lock.TYPE) -> void:
	keys[key] -= 1
	Event.ui_key.emit(key, keys[key])

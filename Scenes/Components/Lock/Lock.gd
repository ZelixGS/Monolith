class_name Lock extends Component

signal insufficent_key
signal unlocked

enum TYPE { NONE, YELLOW, BLUE, RED, SKULL }

@export var key: TYPE = TYPE.YELLOW

func get_color() -> Color:
	match key:
		TYPE.NONE:
			return Color.WHITE
		TYPE.YELLOW:
			return Color(0.85, 0.75, 0.10)
		TYPE.BLUE:
			return Color(0.42, 0.66, 0.96)
		TYPE.RED:
			return Color(0.99, 0.30, 0.36)
		TYPE.SKULL:
			return Color(0.61, 0.59, 0.56)
		_:
			return Color(0.85, 0.75, 0.10)

func check_lock() -> void:
	if GameManager.inventory.has_key(key):
		GameManager.inventory.use_key(key)
		unlocked.emit()
		return
	insufficent_key.emit()

func on_interaction() -> void:
	check_lock()

class_name Lock extends Component

signal insufficent_key
signal unlocked

#func unlock() -> void:
	#if not Game.data.has_key(lock_name):
		#insufficent_key.emit()
		#return
	#Game.data.remove_key(lock_name)
	#unlocked.emit()

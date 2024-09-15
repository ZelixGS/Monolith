extends Node

func get_save_path(file_name: String) -> String:
	return "res://%s" % file_name

#func save_data(file_name: String) -> void:
	#var file = FileAccess.open("%s//%s.save" % [_save_path, file_name], FileAccess.WRITE_READ)
	#file.store_string(content)
#
#
#func load_file(file_name: String) -> void:
	#if not FileAccess.file_exists(get_save_path("Zelix")):
		#printerr("No Save File for %s" % file_name)
	#FileAccess.open()

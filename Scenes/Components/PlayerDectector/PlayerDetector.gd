extends Area2D

signal entered
signal exited

func _on_area_entered(_area: Area2D) -> void:
	entered.emit()

func _on_area_exited(_area: Area2D) -> void:
	exited.emit()

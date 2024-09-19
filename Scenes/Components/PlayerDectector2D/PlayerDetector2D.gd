@icon("res://Scenes/Components/PlayerDectector2D/icon_character.png")
class_name PlayerDetector2D extends Area2D

signal entered
signal exited

func enable() -> void:
	set_deferred("monitoring", true)

func disable() -> void:
	set_deferred("monitoring", false)

func toggle() -> void:
	set_deferred("monitoring", !monitoring)

func _on_area_entered(_area: Area2D) -> void:
	entered.emit()

func _on_area_exited(_area: Area2D) -> void:
	exited.emit()

extends Area2D

signal interaction

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func set_active(value: bool) -> void:
	collision_shape_2d.set_deferred("disabled", !value)

func interact() -> void:
	interaction.emit()

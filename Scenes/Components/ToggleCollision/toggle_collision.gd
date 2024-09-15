class_name ToggleCollison extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func toggle() -> void:
	visible = !visible
	collision_shape_2d.set_deferred("disabled", !collision_shape_2d.disabled)

func set_active(value: bool) -> void:
	visible = value
	collision_shape_2d.set_deferred("disabled", !value)

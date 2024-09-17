class_name ToggleCollision extends StaticBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func enable() -> void:
	collision_shape_2d.set_deferred("disabled", false)

func disable() -> void:
	collision_shape_2d.set_deferred("disabled", true)

func toggle() -> void:
	collision_shape_2d.set_deferred("disabled", !collision_shape_2d.disabled)

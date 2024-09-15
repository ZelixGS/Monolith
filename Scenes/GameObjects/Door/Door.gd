@tool
class_name Door extends GameObject

enum STATE { CLOSED, OPENED, LOCKED, BARRED }

@export_category("Lock")
@export var lock_name: String = "yellow"
@export var lock_color: Color = Color(0.85, 0.75, 0.10):
	set(value):
		lock_color = value
		if sprite_2d:
			sprite_2d.self_modulate = lock_color

@export_category("Sprite")
@export var closed_sprite: Rect2 = Rect2(48, 144, 16, 16)
@export var opened_sprite: Rect2 = Rect2(32, 144, 16, 16)
@export var locked_sprite: Rect2 = Rect2(0, 144, 16, 16)
@export var barred_sprite: Rect2 = Rect2(128, 176, 16, 16)

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

func _on_state_change() -> void:
	if sprite_2d:
		sprite_2d.self_modulate = lock_color
	match state:
		STATE.CLOSED:
			if sprite_2d:
				sprite_2d.region_rect = closed_sprite
			if collision_shape_2d:
				collision_shape_2d.set_deferred("disabled", false)
		STATE.OPENED:
			if sprite_2d:
				sprite_2d.region_rect = opened_sprite
			if collision_shape_2d:
				collision_shape_2d.set_deferred("disabled", true)
		STATE.LOCKED:
			if sprite_2d:
				sprite_2d.region_rect = locked_sprite
			if collision_shape_2d:
				collision_shape_2d.set_deferred("disabled", false)
		STATE.BARRED:
			if sprite_2d:
				sprite_2d.region_rect = barred_sprite
			if collision_shape_2d:
				collision_shape_2d.set_deferred("disabled", false)

func close_door() -> void:
	state = STATE.CLOSED

func open_door() -> void:
	state = STATE.OPENED

func lock_door() -> void:
	state = STATE.LOCKED

func unlock_door() -> void:
	state = STATE.OPENED

func bar_door() -> void:
	state = STATE.BARRED

func _on_interactable_interaction() -> void:
	match state:
		STATE.LOCKED:
			if GameManager.has_key(lock_name):
				GameManager.remove_key(lock_name)
				state = STATE.OPENED
			else:
				pass #TODO Add Sound
		STATE.BARRED:
			pass #TODO Play Sound
		STATE.CLOSED:
			state = STATE.OPENED

@tool
@icon("res://Scenes/GameObjects/Door/icon_door.png")
class_name Door extends GameObject

enum STATE { CLOSED, OPENED, LOCKED, BARRED, SEALED }

@export var key: Lock.TYPE = Lock.TYPE.YELLOW:
	set(value):
		key = value
		call_deferred("set_lock")
		call_deferred("set_color")

@export_category("Sprite")
@export var barred_sprite: Texture2D = preload("res://Assets/Sprites/Doors/Barred.png")
@export var closed_sprite: Texture2D = preload("res://Assets/Sprites/Doors/Closed.png")
@export var locked_sprite: Texture2D = preload("res://Assets/Sprites/Doors/Locked.png")
@export var opened_sprite: Texture2D = preload("res://Assets/Sprites/Doors/Opened.png")
@export var sealed_sprite: Texture2D = preload("res://Assets/Sprites/Doors/Sealed.png")

@onready var lock: Lock = $Lock
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var toggle_collision: ToggleCollision = $ToggleCollision
@onready var interactable_2d: Interactable2D = $Interactable2D

func set_lock() -> void:
	lock.key = key

func set_color() -> void:
	match key:
		Lock.TYPE.NONE:
			sprite_2d.self_modulate = Color.WHITE
		Lock.TYPE.YELLOW:
			sprite_2d.self_modulate = Color(0.85, 0.75, 0.10)
		Lock.TYPE.BLUE:
			sprite_2d.self_modulate = Color(0.42, 0.66, 0.96)
		Lock.TYPE.RED:
			sprite_2d.self_modulate = Color(0.99, 0.30, 0.36)
		Lock.TYPE.SKULL:
			sprite_2d.self_modulate = Color(0.61, 0.59, 0.56)
		_:
			sprite_2d.self_modulate = Color(0.85, 0.75, 0.10)

func on_state_change() -> void:
	match state:
		STATE.CLOSED:
			sprite_2d.texture = closed_sprite
			toggle_collision.enable()
			interactable_2d.enable()
		STATE.OPENED:
			sprite_2d.texture = opened_sprite
			toggle_collision.disable()
			interactable_2d.disable()
		STATE.LOCKED:
			sprite_2d.texture = locked_sprite
			toggle_collision.enable()
			interactable_2d.enable()
		STATE.BARRED:
			sprite_2d.texture = barred_sprite
			toggle_collision.enable()
			interactable_2d.enable()
		STATE.SEALED:
			sprite_2d.texture = sealed_sprite
			toggle_collision.enable()
			interactable_2d.enable()

#region Change State Methods

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

func seal_door() -> void:
	state = STATE.SEALED

#endregion

func _on_lock_unlocked() -> void:
	open_door()

func _on_interactable_2d_interaction() -> void:
	match state:
		STATE.LOCKED:
			lock.check_lock()
		STATE.OPENED:
			pass
		STATE.BARRED:
			pass #TODO Play Sound
		STATE.CLOSED:
			#TODO Play Sound
			state = STATE.OPENED
		STATE.SEALED:
			pass #TODO Play Sound

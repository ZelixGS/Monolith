@tool
class_name Stairs extends GameObject

enum STATE { UP, DOWN }

@export_category("Sprite")
@export var up_sprite: Texture2D = preload("res://Assets/StairsUp.png")
@export var down_sprite: Texture2D = preload("res://Assets/StairsDown.png")

@onready var sprite_2d: ExtendedSprite2D = $Sprite2D
@onready var player_detector: PlayerDetector2D = $PlayerDetector

func on_ready() -> void:
	pass

func on_state_change() -> void:
	if state == STATE.UP:
		sprite_2d.texture = up_sprite
	if state == STATE.DOWN:
		sprite_2d.texture = down_sprite


func _on_player_detector_entered() -> void:
	if state == STATE.UP:
		GameManager.request_transition.emit("up")
	if state == STATE.DOWN:
		GameManager.request_transition.emit("down")

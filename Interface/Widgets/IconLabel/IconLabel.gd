@tool
extends HBoxContainer

@export var text: String = "":
	set(value):
		text = value
		call_deferred("set_label")

@export var texture: Texture2D:
	set(value):
		texture = value
		call_deferred("set_texture")

@export var texture_color: Color = Color.WHITE:
	set(value):
		texture_color = value
		call_deferred("set_texture_color")

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func _ready() -> void:
	set_texture()
	set_label()

func set_label() -> void:
	label.text = text

func set_texture() -> void:
	texture_rect.texture = texture

func set_texture_color() -> void:
	texture_rect.modulate = texture_color

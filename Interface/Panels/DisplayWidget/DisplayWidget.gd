extends HBoxContainer

@export var sprite: Texture2D:
	set(value):
		sprite = value
		if icon:
			icon.texture = sprite

@export var number: int = 100:
	set(value):
		number = value
		if label:
			label.text = format_seperator(number)

@onready var icon: TextureRect = $Icon
@onready var label: Label = $Label

func _ready() -> void:
	if icon:
		icon.texture = sprite
	if label:
		label.text = format_seperator(number)

func format_seperator(num: int, seperator: String = ",") -> String:
	var string: String = str(num)
	var mod: float = string.length() % 3
	var result: String = ""
	for i: int in range(0, string.length()):
		if i != 0 && i % 3 == mod:
			result += seperator
		result += string[i]
	if num < 0:
		result = '-'+result
	return result

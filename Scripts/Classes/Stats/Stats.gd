class_name Stats extends Object

var health: int = 0
var attack: int = 0
var defense: int = 0
var gold: int = 0
var position: Vector2 = Vector2.ZERO
var is_player: bool = false
var texture: Texture2D

func _init(h: int, a: int, d: int, g: int = 0, p: bool = false, t: Texture2D = Texture2D.new()) -> void:
	health = h
	attack = a
	defense = d
	gold = g
	is_player = p
	texture = t

class_name Stats extends Object

var health: int = 0
var attack: int = 0
var defense: int = 0
var gold: int = 0

func _init(h: int, a: int, d: int, g: int = 0) -> void:
	health = h
	attack = a
	defense = d
	gold = g

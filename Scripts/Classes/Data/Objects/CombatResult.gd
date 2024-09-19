class_name CombatResult extends Object

enum VICTOR {AGGRESSOR, DEFENDER}

var victor: VICTOR
var damage_taken: int = 0

func _init(v: VICTOR, d: int) -> void:
	victor = v
	damage_taken = d

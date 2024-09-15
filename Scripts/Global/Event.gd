extends Node

@warning_ignore("unused_signal")
signal player_health(value: int)
signal player_attack(value: int)
signal player_defense(value: int)
signal player_gold(value: int)

signal flag(_flag_res: Flag)
signal state_change(_node_name: String, _state: int)
signal update
signal toggle_settings

signal audio_master(value: float)
signal audio_sound(value: float)
signal audio_music(value: float)
signal audio_ambience(value: float)

signal disable_player_input
signal enable_player_input

signal combat_attacker_victory
signal combat_defender_victory

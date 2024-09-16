extends Node

@warning_ignore("unused_signal")
signal player_health(value: int)
signal player_attack(value: int)
signal player_defense(value: int)
signal player_gold(value: int)
signal player_position(value: Vector2)

signal pickup_health(value: int)
signal pickup_attack(value: int)
signal pickup_defense(value: int)
signal pickup_gold(value: int)
signal pickup_key(value: String)


signal object_state_changed(obj_name: String, state: int)
signal flag(_flag_res: Flag)
signal state_change(_node_name: String, _state: int)
signal update

signal gameplay_start_timer
signal gameplay_stop_timer

signal ui_toggle_menu
signal ui_new_game
signal ui_reload_game
signal ui_quit_game

signal audio_master(value: float)
signal audio_sound(value: float)
signal audio_music(value: float)
signal audio_ambience(value: float)

signal disable_player_input
signal enable_player_input

signal combat_attacker_victory
signal combat_defender_victory

signal game_over

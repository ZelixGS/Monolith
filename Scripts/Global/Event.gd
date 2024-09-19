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
signal pickup_key(value: Lock.TYPE, amount: int)

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
signal ui_key(key: Lock.TYPE, amount: int)


signal ui_combat_start # Loop Started
signal ui_combat_end # Loop Ended

signal ui_combat_window_show # Ask for Window to Open
signal ui_combat_window_hide # Ask for Window to Close

signal ui_combat_window_opened # Window Opened
signal ui_combat_window_closed # Window Closed

signal ui_combat_complete
signal ui_combat_awaiting_accept # Waiting for Accept Button

signal ui_combat_setup_stage(attacker: Stats, defender: Stats)
signal ui_combat_attacker_animation
signal ui_combat_defender_animation
signal ui_combat_attacker_defeated
signal ui_combat_defender_defeated
signal ui_combat_attacker_take_damage(amount: int)
signal ui_combat_defender_take_damage(amount: int)
signal ui_combat_animation_complete

signal audio_master(value: float)
signal audio_sound(value: float)
signal audio_music(value: float)
signal audio_ambience(value: float)

signal disable_player_input
signal enable_player_input

signal combat_attacker_victory
signal combat_defender_victory

signal game_over

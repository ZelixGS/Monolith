extends CenterContainer

@onready var new_game: Button = %NewGame
@onready var reload: Button = %Reload
@onready var quit: Button = %Quit


func _on_new_game_pressed() -> void:
	Event.ui_new_game.emit()

func _on_reload_pressed() -> void:
	Event.ui_reload_game.emit()

func _on_quit_pressed() -> void:
	Event.ui_quit_game.emit()

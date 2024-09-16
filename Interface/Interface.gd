extends CanvasLayer

var allow_menu: bool = true

@onready var gameplay: MarginContainer = $Main/Gameplay
@onready var background: TextureRect = $Main/Background
@onready var menu: MarginContainer = $Main/Menu
@onready var game_over: CenterContainer = $Main/GameOver

func _ready() -> void:
	Event.ui_toggle_menu.connect(toggle_menu)
	Event.game_over.connect(show_game_over)
	gameplay.show()
	background.hide()
	menu.hide()
	game_over.hide()

func _input(event: InputEvent) -> void:
	if allow_menu and event.is_action_pressed("toggle_menu"):
		toggle_menu()

func toggle_menu() -> void:
	if not menu.visible:
		allow_menu = false
		Event.disable_player_input.emit()
		Event.gameplay_stop_timer.emit()
		await Global.fade_in(background)
		await Global.fade_in(menu)
		allow_menu = true
	else:
		allow_menu = false
		await Global.fade_out(menu)
		await Global.fade_out(background)
		Event.enable_player_input.emit()
		Event.gameplay_start_timer.emit()
		allow_menu = true

func show_game_over() -> void:
	allow_menu = false
	Event.disable_player_input.emit()
	await Global.fade_in(background)
	await Global.fade_in(game_over)

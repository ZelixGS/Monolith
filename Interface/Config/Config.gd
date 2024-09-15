extends Control

var allow_menu: bool = true

@onready var options: MarginContainer = $Options
@onready var game_over: CenterContainer = $GameOver

#region Containers
@onready var scroll_container: ScrollContainer = $MarginContainer/HBoxContainer/ScrollContainer
@onready var gameplay: VBoxContainer = %Gameplay
@onready var graphics: VBoxContainer = %Graphics
@onready var audio: VBoxContainer = %Audio
@onready var keybinds: VBoxContainer = %Keybinds
#endregion

#region Buttons
@onready var btn_continue: Button = %BtnContinue
@onready var btn_gameplay: Button = %BtnGameplay
@onready var btn_graphics: Button = %BtnGraphics
@onready var btn_audio: Button = %BtnAudio
@onready var btn_keybindings: Button = %BtnKeybindings
@onready var btn_quit: Button = %BtnQuit
#endregion

func _ready() -> void:
	Event.toggle_settings.connect(toggle)
	Event.combat_defender_victory.connect(start_game_over)
	game_over.hide()

func _input(event: InputEvent) -> void:
	if allow_menu and event.is_action_pressed("toggle_menu"):
		toggle()

func toggle() -> void:
	if not visible:
		Event.disable_player_input.emit()
		enable_buttons()
		modulate = Color.TRANSPARENT
		visible = true
		Global.fade_in(self)
	else:
		await Global.fade_out(self)
		hide_options()
		visible = false
		Event.enable_player_input.emit()

func enable_buttons() -> void:
	btn_continue.disabled = false
	btn_gameplay.disabled = false
	btn_graphics.disabled = false
	btn_audio.disabled = false
	btn_keybindings.disabled = false
	btn_quit.disabled = false

func hide_options() -> void:
	if gameplay.visible:
		await Global.fade_out(gameplay)
		gameplay.hide()
	if graphics.visible:
		await Global.fade_out(graphics)
		graphics.hide()
	if audio.visible:
		await Global.fade_out(audio)
		audio.hide()

func _on_continue_pressed() -> void:
	toggle()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		quit_game()

func _on_quit_pressed() -> void:
	quit_game()

func quit_game(bypass_saving: bool = false) -> void:
	print("Quitting!")
	if not bypass_saving:
		GameManager.save_game()
	get_tree().quit()

func _on_options_button(button_name: String) -> void:
	await hide_options()
	enable_buttons()
	scroll_container.scroll_horizontal = 0
	scroll_container.scroll_vertical = 0
	match button_name:
		"gameplay":
			btn_gameplay.disabled = true
			gameplay.show()
			Global.fade_in(gameplay)
		"graphics":
			btn_graphics.disabled = true
			graphics.show()
			Global.fade_in(graphics)
		"audio":
			btn_audio.disabled = true
			audio.show()
			Global.fade_in(audio)
		"keybinds":
			btn_keybindings.disabled = true
			keybinds.show()
			Global.fade_in(keybinds)

func _on_gameplay_pressed() -> void:
	_on_options_button("gameplay")

func _on_graphics_pressed() -> void:
	_on_options_button("graphics")

func _on_audio_pressed() -> void:
	_on_options_button("audio")

func _on_keybindings_pressed() -> void:
	_on_options_button("keybinds")


#region Game Over Logic

func start_game_over() -> void:
	allow_menu = false
	Event.disable_player_input.emit()
	modulate = Color.TRANSPARENT
	game_over.modulate = Color.TRANSPARENT
	visible = true
	options.hide()
	game_over.visible = true
	await Global.fade_in(self, 1.5)
	await Global.fade_in(game_over, 1.5)

#endregion

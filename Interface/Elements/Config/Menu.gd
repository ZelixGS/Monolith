extends MarginContainer

var wait_for_menu: bool = false

# Buttons
@onready var btn_continue: Button = %BtnContinue
@onready var btn_gameplay: Button = %BtnGameplay
@onready var btn_graphics: Button = %BtnGraphics
@onready var btn_audio: Button = %BtnAudio
@onready var btn_interface: Button = %BtnInterface
@onready var btn_quit: Button = %BtnQuit
@onready var btn_apply_settings: Button = %BtnApplySettings

# Containers
@onready var gameplay: VBoxContainer = %Gameplay
@onready var graphics: VBoxContainer = %Graphics
@onready var audio: VBoxContainer = %Audio
@onready var interface: VBoxContainer = %Interface

#region Continue/Quit Buttons
func _on_btn_continue_pressed() -> void:
	Event.ui_toggle_menu.emit()

func _on_btn_quit_pressed() -> void:
	Event.ui_quit_game.emit()

func _on_apply_settings_pressed() -> void:
	Configuration.apply_settings.emit()
	btn_apply_settings.disabled = true
#endregion

#region Menu Button Presses
func _on_btn_gameplay_pressed() -> void:
	toggle_section("gameplay")

func _on_btn_graphics_pressed() -> void:
	toggle_section("graphics")

func _on_btn_audio_pressed() -> void:
	toggle_section("audio")

func _on_btn_interface_pressed() -> void:
	toggle_section("interface")
#endregion

func _ready() -> void:
	Configuration.setting_changed.connect(enable_apply_settings)

func reset() -> void:
	if btn_gameplay:
		enable_buttons()
	if gameplay:
		hide_all()
	if btn_apply_settings:
		btn_apply_settings.disabled = true

func enable_buttons() -> void:
	btn_gameplay.disabled = false
	btn_graphics.disabled = false
	btn_audio.disabled = false
	btn_interface.disabled = false

func disable_buttons() -> void:
	btn_gameplay.disabled = true
	btn_graphics.disabled = true
	btn_audio.disabled = true
	btn_interface.disabled = true

func hide_all() -> void:
	gameplay.hide()
	graphics.hide()
	audio.hide()
	interface.hide()

func fade_all() -> void:
	if gameplay.visible:
		await Global.fade_out(gameplay, 0.1)
	if graphics.visible:
		await Global.fade_out(graphics, 0.1)
	if audio.visible:
		await Global.fade_out(audio, 0.1)
	if interface.visible:
		await Global.fade_out(interface, 0.1)

func enable_apply_settings(_setting_name: String, _value: Variant) -> void:
	btn_apply_settings.disabled = false

func toggle_section(section: String) -> void:
	if wait_for_menu:
		return
	wait_for_menu = true
	enable_buttons()
	await fade_all()
	match section:
		"gameplay":
			btn_gameplay.disabled = true
			await Global.fade_in(gameplay, 0.15)
		"graphics":
			btn_graphics.disabled = true
			await Global.fade_in(graphics, 0.15)
		"audio":
			btn_audio.disabled = true
			await Global.fade_in(audio, 0.15)
		"interface":
			btn_interface.disabled = true
			await Global.fade_in(interface, 0.15)
	wait_for_menu = false

func _on_visibility_changed() -> void:
	if visible:
		reset()

extends PanelContainer

@onready var touch_left: TouchScreenButton = %TouchLeft
@onready var touch_up: TouchScreenButton = %TouchUp
@onready var touch_down: TouchScreenButton = %TouchDown
@onready var touch_right: TouchScreenButton = %TouchRight
@onready var nine_patch_rect: NinePatchRect = $MarginContainer/AspectRatioContainer/HBoxContainer/Left/AspectRatioContainer/NinePatchRect

func _on_nine_patch_rect_resized() -> void:
	if nine_patch_rect:
		var button_size: Vector2 = nine_patch_rect.size
		touch_left.shape.size = button_size
		touch_up.shape.size = button_size
		touch_down.shape.size = button_size
		touch_right.shape.size = button_size

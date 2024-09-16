class_name Setting extends Resource

enum TYPE { CHECKBOX, SLIDER}

@export var name: String = ""
@export var section: String = "General"
@export var value: Variant = 1.0
@export var default: Variant = 1.0
@export var hidden: bool = false

@export_category("UI")
@export_multiline var details: String = ""
@export var type: TYPE = TYPE.CHECKBOX

@export_subgroup("Slider")
@export var slider_minimum: float = 0.0
@export var slider_maximum: float = 1.0
@export var slider_step: float = 0.05
@export var slider_rounded: bool = false
@export var slider_percentage: bool = false

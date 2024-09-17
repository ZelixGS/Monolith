class_name LevelNode extends TileMapLayer

@export var entrance_from_above: Marker2D
@export var entrance_from_below: Marker2D

@export var objects: Node
@export var camera: Node2D

func _ready() -> void:
	call_deferred("emit_ready")

func emit_ready() -> void:
	GameManager.ready_for_initialization.emit(self)

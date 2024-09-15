class_name Player extends Node2D

var moving: bool = false
var movement_speed: float = 0.175
var allow_input: bool = true

@onready var facing: Node2D = $Facing
@onready var wall_ray: RayCast2D = $Facing/WallRay
@onready var interact_ray: RayCast2D = $Facing/InteractRay

func _ready() -> void:
	Event.connect("enable_player_input", enable_input)
	Event.connect("disable_player_input", disable_input)

func enable_input() -> void:
	allow_input = true

func disable_input() -> void:
	allow_input = false

func _process(_delta: float) -> void:
	if allow_input:
		if Input.is_action_pressed("move_up"):
			move(Vector2.UP)
		if Input.is_action_pressed("move_down"):
			move(Vector2.DOWN)
		if Input.is_action_pressed("move_left"):
			move(Vector2.LEFT)
		if Input.is_action_pressed("move_right"):
			move(Vector2.RIGHT)

func move(direction: Vector2) -> void:
	if moving:
		return
	facing.rotation = direction.angle()
	wall_ray.force_raycast_update()
	interact_ray.force_raycast_update()
	if interact_ray.is_colliding():
		var target: Object = interact_ray.get_collider()
		if target.has_method("interact"):
			target.interact()
	if wall_ray.is_colliding():
		return
	var movement_tween: Tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	movement_tween.tween_property(self, "global_position", global_position + (direction * 16), movement_speed)
	moving = true
	await movement_tween.finished
	moving = false

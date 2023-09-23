extends CharacterBody2D
class_name PlatformerController

@export var stats: PlayerStats
@export var input_maps: InputMaps

var hori_input: float
var jump_input: bool

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	hori_input = Input.get_axis(input_maps.left, input_maps.right)

func _physics_process(delta: float) -> void:
	velocity.x = hori_input * stats.move_speed
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_pressed(input_maps.up):
			velocity.y = -stats.jump_velocity
	else:
		velocity.y += stats.gravity_accel * delta
	move_and_slide()

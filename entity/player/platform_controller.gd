extends CharacterBody2D
class_name PlatformerController

@export var stats: PlayerStats
@export var input_maps: InputMaps

var hori_input: float
var jump_input: bool

# if bounced, not in control
var bounced: bool

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	hori_input = Input.get_axis(input_maps.left, input_maps.right)

	# debugging crap
	if position.y > 2000:
		velocity = Vector2.ZERO
		position = Vector2.ZERO
		bounced = false

func _physics_process(delta: float) -> void:
	if not bounced:
		velocity.x = hori_input * stats.move_speed
	if is_on_floor() and velocity.y >= 0:
		velocity.y = 0
		bounced = false
		if Input.is_action_pressed(input_maps.up):
			velocity.y = -stats.jump_velocity
	else:
		velocity.y += stats.gravity_accel * delta
	
	if bounced and absf(velocity.x) < stats.move_speed * 0.1: # arbitrary condition
		bounced = false
		print_debug("endbounce fx by vx")
	if bounced:
		velocity.x -= velocity.x * 0.5 * delta
	move_and_slide()

func bounce(vector: Vector2, strength: float) -> void:
	bounced = true
	velocity = vector.normalized() * strength

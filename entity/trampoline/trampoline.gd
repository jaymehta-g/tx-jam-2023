extends CharacterBody2D
class_name Trampoline

@export var speed: float
@export var decel: float
@export var gravity_accel: float
@export var bump_force: float

@onready var player_area: Area2D = $"Area2D"
@onready var spring_anim_player: AnimationPlayer = $"Bounce"
@onready var fade_anim_player: AnimationPlayer = $"Fade Out Animation"
@onready var disappear_timer: Timer = $"Disappear Timer"

func _ready() -> void:
	disappear_timer.timeout.connect(func(): fade_anim_player.play("fade out"))

func init(face_right: bool) -> Trampoline:
	if not face_right: speed *= -1 # not great but wtv
	velocity = speed * Vector2.RIGHT
	return self

func _physics_process(delta: float) -> void:
	if is_on_wall() or is_zero_approx(velocity.x):
		velocity.x=0
	else:
		velocity.x += -sign(velocity.x) * decel * delta
	if not is_on_floor():
		velocity.y+=gravity_accel * delta
	else:
		velocity.y = 0
	move_and_slide()

func _on_area_2d_body_entered(body:Node2D) -> void:
	if not body is Player:
		return
	var player := body as Player
	player_area.queue_free()

	var bounce_vector := Vector2.UP * bump_force
	bounce_vector.x = velocity.x
	var magnitude := bounce_vector.length()
	$"Visible".modulate = Color.WHITE
	player.bounce(bounce_vector, magnitude)
	player.play_bounce()
	spring_anim_player.play("bounce")
	spring_anim_player.animation_finished.connect(func(_a): queue_free())

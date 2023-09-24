extends Area2D

@export var strength: float
@onready var sprite: Sprite2D = $"Sprite2D"
@onready var timer: Timer = $"Disappear Timer"
@onready var fade_animation: AnimationPlayer = $"Fade Out Animation"
@onready var remove_animation: AnimationPlayer = $"Remove Animation"

var durability = 3

func _ready() -> void:
	$"Enable".play("enable")
	timer.timeout.connect(func(): fade_animation.play("fade out"))


func _on_body_entered(body:Node2D) -> void:
	if not body is Player:
		return
	var player := body as Player
	var player_pos := player.position

	# if the player is going fast enough, they could have already clipped through
	# the area before this method call
	# So, approximate the player pos 1 frame ago
	var player_vel := player.velocity
	var player_approx_movement_last_frame := player_vel * get_physics_process_delta_time()
	var last_player_pos := player_pos - player_approx_movement_last_frame
	var bounce_dir = last_player_pos - position

	player.bounce(bounce_dir, strength)

	durability -= 1

	$"Bounce".play("bounce")
	player.play_bounce()
	fade_animation.play("RESET")

	timer.start()

func destroy_if_durability_out():
	if durability <= 0:
		remove_animation.play("remove")
		remove_animation.animation_finished.connect(func(_a): queue_free())
		

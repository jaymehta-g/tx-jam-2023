extends Area2D

@export var strength: float
var durability = 3

func _ready() -> void:
	$"Enable".play("enable")

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

func destroy_if_durability_out():
	if durability <= 0:
		queue_free()
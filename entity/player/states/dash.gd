extends State

var player: Player
var stats: PlayerStats

var dash_right: bool

var dash_dist_remaining: float # how many px there are left to dash

func state_enter() -> void:
	player = base
	stats = player.stats
	dash_right = player.facing_right
	dash_dist_remaining = stats.dash_distance
	player.velocity.y = 0

func state_process_physics(delta: float) -> void:
	var x_to_move = delta * stats.dash_speed
	dash_dist_remaining -= x_to_move
	var move_success := player.move_and_collide(Vector2.RIGHT * x_to_move * player.facing_right_multiplier)
	if dash_dist_remaining <= 0 or move_success != null:
		transition_state("move")

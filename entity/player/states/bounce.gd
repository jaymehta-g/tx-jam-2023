extends State

var player: Player
var stats: PlayerStats

func state_process_physics(delta: float) -> void:
	if player.is_on_floor() and player.velocity.y >= 0:
		transition_state("move")
	player.velocity.y += stats.gravity_accel * delta
	if absf(player.velocity.x) < stats.move_speed * 0.1: # arbitrary condition
		transition_state("move")
	player.velocity.x -= player.velocity.x * 0.5 * delta

	player.move_and_slide()

func state_enter() -> void:
	player = base
	stats = player.stats

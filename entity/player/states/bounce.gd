extends State

var player: Player
var stats: PlayerStats

@export var right_raycast: RayCast2D
@export var left_raycast: RayCast2D

func state_process_physics(delta: float) -> void:
	# player.velocity.y += stats.gravity_accel * delta
	# if absf(player.velocity.x) < stats.move_speed * 0.5: # arbitrary condition
	# 	transition_state("move")
	# if player.is_on_floor():
	# 	player.velocity.x -= player.velocity.x * 2 * delta
	# else:
	# 	player.velocity.x -= player.velocity.x * 1 * delta

	const BOUNCE_DAMP := 1.0 # TODO move to stats

	player.velocity.y += stats.gravity_accel * delta
	if player.is_on_floor() and player.velocity.length() < 100: # magic number must fix
		transition_state("move")
	
	# bounce around
	if player.is_on_floor() and player.velocity.y > 0:
		player.velocity.y = -absf(player.velocity.y) * BOUNCE_DAMP
	if player.is_on_ceiling() and player.velocity.y < 0:
		player.velocity.y = absf(player.velocity.y) * BOUNCE_DAMP
		print_debug("bounce ceil")
	if player.is_on_wall():
		var abs_x_vel := absf(player.velocity.x)
		if right_raycast.is_colliding() and player.velocity.x > 0:
			player.velocity.x = -abs_x_vel * BOUNCE_DAMP
		elif left_raycast.is_colliding() and player.velocity.x < 0:
			player.velocity.x = abs_x_vel * BOUNCE_DAMP

	
	player.move_and_slide()

func state_enter() -> void:
	print_debug("bounce enter")
	player = base
	stats = player.stats

func state_exit() -> void:
	print_debug("state exit")
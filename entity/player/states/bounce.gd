extends State

var player: Player
var stats: PlayerStats

@export var right_raycast: RayCast2D
@export var left_raycast: RayCast2D
@export var remote_transform: RemoteTransform2D

var fly_particles: GPUParticles2D

var new_velocity: Vector2

func state_process_physics(delta: float) -> void:
	const BOUNCE_DAMP := 0.7 # TODO move to stats


	new_velocity.y += stats.gravity_accel * delta
	if new_velocity.length() < 100: # magic number must fix
		player.velocity = new_velocity
		transition_state("move")
	
	# bounce around
	if player.is_on_floor() and new_velocity.y > 0:
		new_velocity.y = -absf(new_velocity.y) * BOUNCE_DAMP
	if player.is_on_ceiling() and new_velocity.y < 0:
		new_velocity.y = absf(new_velocity.y) * BOUNCE_DAMP
	if player.is_on_wall():
		var abs_x_vel := absf(new_velocity.x)
		if right_raycast.is_colliding() and new_velocity.x > 0:
			new_velocity.x = -abs_x_vel * BOUNCE_DAMP
		elif left_raycast.is_colliding() and new_velocity.x < 0:
			new_velocity.x = abs_x_vel * BOUNCE_DAMP

	# horizontal damping so you can come to a stop
	new_velocity.x -= new_velocity.x * 2 * delta

	player.velocity = new_velocity
	player.move_and_slide()

	# juice
	const EMISSION_BY_SPEED := 4
	var particles_speed := new_velocity.length()
	fly_particles.amount = floori(EMISSION_BY_SPEED*particles_speed)

func state_enter() -> void:
	player = base
	stats = player.stats
	new_velocity = player.velocity
	fly_particles = ResourceManager.SMOKE_TRAIL_SCENE.instantiate()
	fly_particles.set_emitting(true)
	player.add_to_level.emit(fly_particles)
	remote_transform.remote_path = fly_particles.get_path()

func state_exit() -> void:
	fly_particles.queue_free()

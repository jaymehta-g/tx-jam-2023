extends State

var player: Player

var hori_input: float
var jump_input: bool

var stats: PlayerStats

func state_enter() -> void:
	player = base
	stats = player.stats

func state_process(_delta: float) -> void:
	var input_maps := player.input_maps
	hori_input = Input.get_axis(input_maps.left, input_maps.right)
	jump_input = Input.is_action_pressed(input_maps.up)

	if Input.is_action_just_pressed(input_maps.dash):
		transition_state("dash")
	
	# feels weird putting this here but
	if Input.is_action_just_pressed(input_maps.use):
		var node: Node2D = player.dbg_bumper_scene.instantiate()
		node.position = player.position + (1 if player.facing_right else -1) * 100 * Vector2.RIGHT # dumb and bad
		player.add_to_level.emit(node)

func state_process_physics(delta: float) -> void:
	player.velocity.x = hori_input * stats.move_speed
	if player.is_on_floor():
		if jump_input:
			player.velocity.y = -stats.jump_velocity
	else:
		player.velocity.y += stats.gravity_accel * delta
	player.move_and_slide()

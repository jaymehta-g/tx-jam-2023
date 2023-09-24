extends State

@onready var dash_cooldown_timer := $"Dash Timer" as Timer

var player: Player

var hori_input: float
var jump_input: bool

var stats: PlayerStats

var in_air: bool

func state_enter() -> void:
	player = base
	stats = player.stats

func state_process(_delta: float) -> void:
	var input_maps := player.input_maps
	hori_input = Input.get_axis(input_maps.left, input_maps.right)
	jump_input = Input.is_action_pressed(input_maps.up)

	if Input.is_action_just_pressed(input_maps.dash) and player.can_dash and dash_cooldown_timer.is_stopped():
		transition_state("dash")
		dash_cooldown_timer.start()
		player.can_dash = false
	
	if Input.is_action_just_pressed(input_maps.use):
		if player.held_trap_amount > 0:
			transition_state("place")
		else:
			player.use.emit(player)
	
func state_process_physics(delta: float) -> void:
	player.velocity.x = hori_input * stats.move_speed
	if player.is_on_floor():
		if jump_input:
			player.velocity.y = -stats.jump_velocity
		player.can_dash = true # put this here bc it uses a physics method
	else:
		in_air = true
		player.velocity.y += stats.gravity_accel * delta
	
	if player.fall_sfx and in_air and player.is_on_floor():
		in_air = false
	
	player.move_and_slide()

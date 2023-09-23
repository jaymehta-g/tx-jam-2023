extends State

@export var bouncer_shape_cast: ShapeCast2D

var player: Player

func state_enter() -> void:
	player = base
	if player.held_trap_type == TrapType.BOUNCER:
		var node := ResourceManager.BUMPER_SCENE.instantiate()
		var position: Vector2
		if bouncer_shape_cast.is_colliding():
			position = bouncer_shape_cast.get_collision_point(0)
		else:
			position = player.position + bouncer_shape_cast.target_position * player.facing_right_multiplier
		node.position = position
		player.add_to_level.emit(node)
	transition_state("move")
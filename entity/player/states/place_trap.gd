extends State

@export var bouncer_shape_cast: Area2D

var player: Player

var bouncer_is_colliding := false

func state_enter() -> void:
	player = base
	place_trap(player.held_trap_type)
	transition_state("move")

func place_trap(trap: int) -> bool:
	if player.held_trap_type == TrapType.BOUNCER:
		var node := ResourceManager.BUMPER_SCENE.instantiate()
		if bouncer_is_colliding:
			return false
		else:
			node.position = bouncer_shape_cast.position
			node.position += player.position 
			player.add_to_level.emit(node)
	return true

func _process(delta: float) -> void:
	bouncer_shape_cast.position.x = abs(bouncer_shape_cast.position.x) * base.facing_right_multiplier

func _on_bouncer_placement_body_exited(body:Node2D) -> void:
	bouncer_is_colliding = false


func _on_bouncer_placement_body_entered(body:Node2D) -> void:
	bouncer_is_colliding = true

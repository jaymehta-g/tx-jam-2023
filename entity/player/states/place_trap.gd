extends State

@export var bouncer_shape_cast: Area2D

var player: Player

var bouncer_is_colliding := false

func state_enter() -> void:
	player = base
	if player.held_trap_type == TrapType.BOUNCER:
		var node := ResourceManager.BUMPER_SCENE.instantiate()
		if not bouncer_is_colliding:
			node.position = bouncer_shape_cast.position
			node.position += player.position 
			player.add_to_level.emit(node)
	transition_state("move")

func _process(delta: float) -> void:
	bouncer_shape_cast.position.x = abs(bouncer_shape_cast.position.x) * base.facing_right_multiplier

func _on_bouncer_placement_body_exited(body:Node2D) -> void:
	bouncer_is_colliding = false


func _on_bouncer_placement_body_entered(body:Node2D) -> void:
	bouncer_is_colliding = true

extends State

@export var trap_collision_container: Node2D # for flipping them on player turn around
@export var bouncer_shape_cast: Area2D
@export var trampoline_shape: Area2D

var player: Player

var bouncer_is_colliding := false
var trampoline_is_colliding := false

func _ready() -> void:
	bouncer_shape_cast.body_entered.connect(func(_c): bouncer_is_colliding = true)
	bouncer_shape_cast.body_exited.connect(func(_c): bouncer_is_colliding = false)
	trampoline_shape.body_entered.connect(func(_c): trampoline_is_colliding = true)
	trampoline_shape.body_exited.connect(func(_c): trampoline_is_colliding = false)

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
	trap_collision_container.scale.x = base.facing_right_multiplier